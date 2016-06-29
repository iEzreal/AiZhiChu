//
//  BluetoothManager.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/23.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BluetoothManagerDelegate <NSObject>

@required
- (void)bluetoothChangeState:(NSInteger)state;

@optional
- (void)deviceConnectResult:(NSError *)error;
- (void)deviceDisconnectResult:(NSError *)error;
- (void)receiveData:(NSData *)data error:(NSError *)error;
- (void)writeDataResult:(NSError *)error;

@end

@interface BluetoothManager : NSObject

@property(nonatomic, weak) id<BluetoothManagerDelegate> delegate ;
@property(nonatomic, assign, getter=isConnect) BOOL Connect;


+ (BluetoothManager *)sharedManager;
- (void)startScanPeripheral;
- (void)stopScanPeripheral;

- (void)connectPeripheral;
- (void)disConnectPeripheral;

- (void)readNotifyValue;
- (void)writeData:(NSData *)data;

@end
