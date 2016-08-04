
//
//  BluetoothManager.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/23.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "BluetoothManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BluetoothManager () <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *bleCentralM;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBService *service;
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;
@property (nonatomic, strong) CBCharacteristic *notifyCharacteristc;


@end

@implementation BluetoothManager

static BluetoothManager *instance = nil;
+ (BluetoothManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (!(self = [super init])) {
        return self;
    }
    
    _bleCentralM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    return self;
}

#pragma mark - CBCentralManagerDelegate
/****************************************************************************/
/*								 蓝牙状态更新                                 */
/****************************************************************************/
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    DLog(@"====== 蓝牙状态改变 ======：%ld", (long)central.state);
    _state = central.state;
    if ([self.delegate respondsToSelector:@selector(bluetoothChangeState:)]) {
        [self.delegate bluetoothChangeState:central.state];
    }
}

/****************************************************************************/
/*								 发现外设                                    */
/****************************************************************************/
- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    if ([peripheral.name isEqualToString:@"moxibustion"]) {
        DLog(@"====== 发现外设 ======：%@", peripheral.name);
        _peripheral = peripheral;
        [_bleCentralM stopScan];
        [self connectPeripheral];
    }
}

/****************************************************************************/
/*					     	   外设连接结果回调                                */
/****************************************************************************/
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    DLog(@"====== 连接外设成功 ======");
    _peripheral = peripheral;
    _peripheral.delegate = self;
    [_peripheral discoverServices:nil];
    if ([self.delegate respondsToSelector:@selector(deviceConnectResult:)]) {
        [self.delegate deviceConnectResult:nil];
    }

}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(deviceConnectResult:)]) {
        [self.delegate deviceConnectResult:error];
    }
}

/****************************************************************************/
/*					     	   外设断开结果回调                                */
/****************************************************************************/
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(deviceDisconnectResult:)]) {
        [self.delegate deviceDisconnectResult:error];
    }
}

/****************************************************************************/
/*								 发现服务                                    */
/****************************************************************************/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error) {
        DLog(@"===== 搜索服务失败 =====: %@ ", error);
        return;
    }
    DLog(@"====== 搜索服务成功 ======");
    for (CBService *ser in peripheral.services) {
        [_peripheral discoverCharacteristics:nil forService:ser];
    }
}

/****************************************************************************/
/*								 发现特征                                    */
/****************************************************************************/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        DLog(@"===== 搜索服务特征失败 =====: %@ ", error);
    }
    for (CBCharacteristic *characteristic in service.characteristics) {
        if ([characteristic.UUID.UUIDString isEqualToString:@"FFF2"]) {
            DLog(@"====== 搜索服务写特征成功 ======");
            _writeCharacteristic = characteristic;
            
        } else if ([characteristic.UUID.UUIDString isEqualToString:@"FFF4"]) {
            DLog(@"====== 搜索服务读特征成功 ======");
            _notifyCharacteristc = characteristic;
            [_peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

#pragma mark - CBPeripheralDelegate
/****************************************************************************/
/*							接收数据、向设备写数据回调                           */
/****************************************************************************/
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    DLog(@"===== 接收数据结果回调 =====%@",characteristic.value);
    if ([self.delegate respondsToSelector:@selector(receiveData:error:)]) {
        [self.delegate receiveData:characteristic.value error:error];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    DLog(@"===== 写数据结果回调 =====");
    if ([self.delegate respondsToSelector:@selector(writeDataResult:)]) {
        [self.delegate writeDataResult:error];
    }
}

#pragma mark - 外部操作方法
/****************************************************************************/
/*								 扫描外设                                    */
/****************************************************************************/
- (void)startScanPeripheral {
    NSDictionary *scanOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    [_bleCentralM scanForPeripheralsWithServices:nil options:scanOptions];
}

- (void)stopScanPeripheral {
    [_bleCentralM stopScan];
}

/****************************************************************************/
/*								 连接、断开外设                               */
/****************************************************************************/
- (void)connectPeripheral {
    NSDictionary *connectOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey];
    [_bleCentralM connectPeripheral:_peripheral options:connectOptions];
}

- (void)disConnectPeripheral {
    if (_peripheral.state == CBPeripheralStateConnected) {
        [_bleCentralM cancelPeripheralConnection:_peripheral];
    }
}

- (BOOL)isConnect {
    if (_peripheral && _peripheral.state == CBPeripheralStateConnected) {
        return true;
    }
    return false;
}

/****************************************************************************/
/*							   写数据到外设                                   */
/****************************************************************************/
- (void)writeData:(NSData *)data {
    if (_writeCharacteristic) {
        [_peripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
        return;
    }
}

/****************************************************************************/
/*							   读外设NotifyValue                             */
/****************************************************************************/
- (void)readNotifyValue {
    if(_notifyCharacteristc) {
        [_peripheral setNotifyValue:YES forCharacteristic:_notifyCharacteristc];
    }
}


@end
