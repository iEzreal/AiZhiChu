//
//  AZCDeviceMenuView.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/21.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZCDeviceMenuView : UIView

@property(nonatomic, assign) BOOL isShow;

- (void)showWithView:(UIView *)superView;
- (void)dismiss;

@end
