//
//  AZCNoDeviceView.h
//  AiZhiChu
//
//  Created by Ezreal on 16/10/11.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZCNoDeviceView;
@protocol AZCNoDeviceViewDelegate <NSObject>

- (void)addDeviceAction;

@end

@interface AZCNoDeviceView : UIView

@property(nonatomic, weak) id<AZCNoDeviceViewDelegate> delegate;

@end
