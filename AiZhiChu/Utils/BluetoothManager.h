//
//  BluetoothManager.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/23.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DevicePairResult) {
    DevicePairResultSuccess,
    DevicePairResultFail
};

@protocol BluetoothManagerDelegate <NSObject>

@required
- (void)devicePairResult:(NSError *)error;

@optional
- (void)receiveDeviceNotifyValue:(NSData *)data;

@end

@interface BluetoothManager : NSObject

@property(nonatomic, weak) id<BluetoothManagerDelegate> delegate ;

+ (BluetoothManager *)sharedManager;
- (void)startScanPeripheral;
- (void)stopScanPeripheral;
- (void)readNotifyValue;
- (void)writeData:(NSData *)data;

@end
