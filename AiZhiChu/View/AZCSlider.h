//
//  AZCSlider.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/20.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZCSlider;
@protocol AZCSliderDelegate <NSObject>

- (void)slider:(AZCSlider *)slider didSelectValue:(CGFloat)value;

@end

@interface AZCSlider : UIControl

@property(nonatomic, weak) id<AZCSliderDelegate> delegate;

@property(nonatomic, assign) CGFloat minimumValue;
@property(nonatomic, assign) CGFloat maximumValue;
@property(nonatomic, assign) CGFloat sliderValue;

@end
