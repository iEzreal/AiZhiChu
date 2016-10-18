//
//  DeviceManager.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/27.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZCDevice.h"

@interface DeviceManager : NSObject

@property(nonatomic, strong) AZCDevice *currentDevice;

+ (DeviceManager *)sharedManager;
- (void)archiveDevices;
- (void)unarchiveDevices;

@end
