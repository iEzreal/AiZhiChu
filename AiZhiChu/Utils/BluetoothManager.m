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
/*								 蓝牙状态                                    */
/****************************************************************************/
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if ([central state] == CBCentralManagerStatePoweredOn) {
        [self startScanPeripheral];
    } else {
        NSLog(@"====== 蓝牙不可用 ======");
    }
}

/****************************************************************************/
/*								 发现外设                                    */
/****************************************************************************/
- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    if ([peripheral.name isEqualToString:@"moxibustion"]) {
        [_bleCentralM stopScan];
        NSLog(@"====== 发现外设 ======");
        NSLog(@"%@", peripheral);
        _peripheral = peripheral;
        [self connectPeripheral:_peripheral];
    }
}

/****************************************************************************/
/*					     	   外设连接结果回调                                */
/****************************************************************************/
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"====== 连接外设成功 ======");
    _peripheral = peripheral;
    _peripheral.delegate = self;
    [_peripheral discoverServices:nil];
    if ([self.delegate respondsToSelector:@selector(devicePairResult:)]) {
        [self.delegate devicePairResult:nil];
    }

}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    [self.delegate devicePairResult:error];
}

/****************************************************************************/
/*								 发现服务                                    */
/****************************************************************************/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
        NSLog(@"====== 发现外设服务成功 ======");
        for (CBService *ser in peripheral.services) {
            [_peripheral discoverCharacteristics:nil forService:ser];
        }
        
    } else {
        NSLog(@"discover service error: %@ ", error);
    }
}

/****************************************************************************/
/*								 发现特征                                    */
/****************************************************************************/
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    if (!error) {
        NSLog(@"====== 发现外设特征 ======");
        for (CBCharacteristic *characteristic in service.characteristics) {
            NSLog(@"service:%@", service.UUID.UUIDString);
            NSLog(@"character:%@", characteristic.UUID.UUIDString);
            
            if ([characteristic.UUID.UUIDString isEqualToString:@"FFF2"]) {
                _writeCharacteristic = characteristic;
            } else if ([characteristic.UUID.UUIDString isEqualToString:@"FFF4"]) {
                _notifyCharacteristc = characteristic;
                [_peripheral setNotifyValue:YES forCharacteristic:characteristic];
                
            }
        }
        
    } else {
        NSLog(@"discover characteristic error: %@ ", error);
    }
}

#pragma mark - CBPeripheralDelegate
/****************************************************************************/
/*							接收 notify value 回调                           */
/****************************************************************************/
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
        
        if ([self.delegate respondsToSelector:@selector(receiveDeviceNotifyValue:)]) {
            [self.delegate receiveDeviceNotifyValue:[[NSData alloc] initWithData:characteristic.value]];
        }
//        NSLog(@"==== 接收 notify value ====");
//        NSData *responseData = [[NSData alloc] initWithData:characteristic.value];
//        Byte *value = (Byte *)[responseData bytes];
//        for(int i =0; i < [responseData length]; i++) {
//            NSLog(@"==== 接受的值 ===%hhu", value[i]);
//            NSString *str = [NSString stringWithFormat:@"%hhu",value[i]];
//            NSLog(@"hhhhhhh: %@", str);
//            NSLog(@"kkkkkkk: %d", [DataConversionUtil byte2Int:value[i]]);
        
//        }
    }
}

/****************************************************************************/
/*							    写数据结果回调                                */
/****************************************************************************/
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"==== 写数据失败 ==== %@", error);
        return;
    }
    
    NSLog(@"==== 写数据成功 ====");
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
/*								 连接外设                                    */
/****************************************************************************/
- (void)connectPeripheral:(CBPeripheral *)peripheral {
    NSDictionary *connectOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey];
    [_bleCentralM connectPeripheral:peripheral options:connectOptions];
}


- (void)disConnectPeripheral:(CBPeripheral *)peripheral {
    [_bleCentralM cancelPeripheralConnection:peripheral];
}


/****************************************************************************/
/*							   写数据到外设                                   */
/****************************************************************************/
- (void)writeData:(NSData *)data {
    if (!_writeCharacteristic) {
        NSLog(@"当前没有匹配的特征值");
        return;
    }
    [_peripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

/****************************************************************************/
/*							   读外设NotifyValue                             */
/****************************************************************************/
- (void)readNotifyValue {
    if(!_notifyCharacteristc) {
        NSLog(@"当前没有匹配的特征值");
        return;
    }
    [_peripheral setNotifyValue:YES forCharacteristic:_notifyCharacteristc];
    
}


@end
