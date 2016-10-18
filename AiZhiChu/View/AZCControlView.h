//
//  AZCControlView.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/21.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZCControlView;
@protocol AZCControlViewDelegate <NSObject>

- (void)controlView:(AZCControlView *)controlView didSelectValue:(CGFloat)value;

@end

@interface AZCControlView : UIView

@property(nonatomic, weak) id<AZCControlViewDelegate> delegate;

@property(nonatomic, assign) CGFloat minimumValue;
@property(nonatomic, assign) CGFloat maximumValue;
@property(nonatomic, assign) CGFloat sliderValue;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
