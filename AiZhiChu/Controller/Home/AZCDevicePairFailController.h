//
//  AZCDevicePairFailController.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/22.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCBaseController.h"

@protocol AZCDevicePairFailReconnectDelegate <NSObject>

- (void)devicePairFailReconnect;

@end

@interface AZCDevicePairFailController : AZCBaseController

@property(nonatomic, weak) id<AZCDevicePairFailReconnectDelegate> delegate;

@end
