//
//  AZCSlider.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/20.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCSlider.h"

#define HANDLE_W 30

@interface AZCSlider ()

@property(nonatomic, strong) UIImageView *normalView;
@property(nonatomic, strong) UIImageView *trackView;
@property(nonatomic, strong) UIImageView *handleView;

@property(nonatomic, strong) UIView *bubbleView;
@property(nonatomic, strong) UIImageView *valueBg;
@property(nonatomic, strong) UILabel *valueLabel;

@property(nonatomic, assign) CGFloat pointY;
@property(nonatomic, assign) CGFloat sliderH; // 滑动条高


@end

@implementation AZCSlider

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return self;
    }
    
    _sliderValue = 0;
    _minimumValue = 0;
    _maximumValue = 1;
    _sliderH = self.frame.size.height - HANDLE_W;
    [self calculationPointY];
    
    // 默认视图
    _normalView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HANDLE_W / 2, self.frame.size.width, _sliderH)];
    _normalView.image = [UIImage imageNamed:@"slider_normal"];
    [self addSubview:_normalView];
    
    
    // 划过的视图
    _trackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _pointY, self.frame.size.width, [self calculationTrackSliderH])];
    _trackView.image = [UIImage imageNamed:@"slider_track"];
    [self addSubview:_trackView];
    
    
    // 滑块视图
    _handleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , HANDLE_W, HANDLE_W)];
    _handleView.center = CGPointMake(10, _pointY);
    _handleView.image = [UIImage imageNamed:@"slider_handle"];
    [self addSubview:_handleView];
    
    _bubbleView = [[UIView alloc] init];
    _bubbleView.frame = CGRectMake(CGRectGetMaxX(_handleView.frame) + 5, _pointY - 30, 50, 30);
    [self addSubview:_bubbleView];
    
    _valueBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    _valueBg.image = [UIImage imageNamed:@"bubble_left"];
    [_bubbleView addSubview:_valueBg];
    
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.textColor = [UIColor blackColor];
    _valueLabel.text = [NSString stringWithFormat:@"%.0f", _sliderValue];
    [_bubbleView addSubview:_valueLabel];
    
    return self;
}

- (void)setMinimumValue:(CGFloat)minimumValue {
    _minimumValue = minimumValue;
    [self calculationPointY];
    _trackView.frame = CGRectMake(0, _pointY, self.frame.size.width, [self calculationTrackSliderH]);
    _handleView.center = CGPointMake(10, _pointY);
    _bubbleView.frame = CGRectMake(CGRectGetMaxX(_handleView.frame) + 5, _pointY - 30, 50, 30);
    
}

- (void)setMaximumValue:(CGFloat)maximumValue {
    _maximumValue = maximumValue;
    [self calculationPointY];
    _trackView.frame = CGRectMake(0, _pointY, self.frame.size.width, [self calculationTrackSliderH]);
    _handleView.center = CGPointMake(10, _pointY);
    _bubbleView.frame = CGRectMake(CGRectGetMaxX(_handleView.frame) + 5, _pointY - 30, 50, 30);
    
}

- (void)setSliderValue:(CGFloat)sliderValue {
    if (sliderValue < _minimumValue) {
        _sliderValue = _minimumValue;
        
    } else if (sliderValue > _maximumValue) {
        _sliderValue = _maximumValue;
        
    } else {
    
        _sliderValue = sliderValue;
    }

    [self calculationPointY];
    _trackView.frame = CGRectMake(0, _pointY, self.frame.size.width, [self calculationTrackSliderH]);
    _handleView.center = CGPointMake(10, _pointY);
    _bubbleView.frame = CGRectMake(CGRectGetMaxX(_handleView.frame) + 5, _pointY - 30, 50, 30);
    _valueLabel.text = [NSString stringWithFormat:@"%.0f", _sliderValue];
}

/**
 *  计算初始值时滑块的位置：pointY
 */
- (void)calculationPointY {
    
    // 滑动条已划过区域的高
    CGFloat trackH = _sliderH / (_maximumValue - _minimumValue) * (_sliderValue -  _minimumValue);
    
    // 滑动条已划过区域的Y坐标
    _pointY = self.frame.size.height - HANDLE_W / 2 - trackH;
}

/**
 *  计算滑动条 已滑动区域高度
 *
 *  @return
 */
- (CGFloat)calculationTrackSliderH {
    return  self.frame.size.height - _pointY - HANDLE_W / 2 ;
}

/**
 *  根据滑动位置计算滑动值
 *
 *  @return
 */
- (CGFloat)calculationSliderValue {
    return _maximumValue - roundf((_pointY - HANDLE_W / 2) / (self.frame.size.height - HANDLE_W) * (_maximumValue - _minimumValue));
}

/**
 *  滑动更新状态
 *
 *  @param touch
 */
- (void)updatePosition:(UITouch *)touch {
    CGPoint point = [touch locationInView:self];
    _pointY = point.y;
    if (point.y < HANDLE_W / 2) {
        _pointY = HANDLE_W / 2;
        
    } else if (point.y > _sliderH) {
        _pointY = _sliderH + HANDLE_W / 2;
    }
    
    _trackView.frame = CGRectMake(0, _pointY, self.frame.size.width, [self calculationTrackSliderH]);
    _handleView.center = CGPointMake(HANDLE_W / 2 - 5, _pointY);
    _bubbleView.frame = CGRectMake(CGRectGetMaxX(_handleView.frame) + 5, _pointY - 30, 50, 30);
    _sliderValue = [self calculationSliderValue];
    _valueLabel.text = [NSString stringWithFormat:@"%.0f", _sliderValue];
    
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self updatePosition:touch];
    return true;

}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self updatePosition:touch];
    return true;

}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(UIEvent *)event {
    [self updatePosition:touch];
    if ([self.delegate respondsToSelector:@selector(slider:didSelectValue:)]) {
        [self.delegate slider:self didSelectValue:_sliderValue];
    }
}

@end
