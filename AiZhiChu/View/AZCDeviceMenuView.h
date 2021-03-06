//
//  AZCDeviceMenuView.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/21.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AZCDeviceMenuViewDelegate <NSObject>

- (void)addDevice;
- (void)deleteDevice;
- (void)connectDevice;
- (void)disconnectDevice;

@end

@interface AZCDeviceMenuView : UIView

@property(nonatomic, weak) id<AZCDeviceMenuViewDelegate> delegate;

@property(nonatomic, strong) UIViewController *superController;
@property(nonatomic, assign) BOOL isShow;

- (void)updateDevice:(AZCDevice *)device;
- (void)updateDeviceState:(BOOL)state;
- (void)showWithView:(UIViewController *)superController;
- (void)dismiss;

@end
