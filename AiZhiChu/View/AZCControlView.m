//
//  AZCControlView.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/21.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCControlView.h"
#import "AZCSlider.h"

#define BUTTON_W 30
#define SLIDER_W 20


@interface AZCControlView () <AZCSliderDelegate>
@property(nonatomic, strong) UIButton *addButton;
@property(nonatomic, strong) UIButton *subButton;
@property(nonatomic, strong) AZCSlider *slider;

@property(nonatomic, strong) UILabel *label;

@end

@implementation AZCControlView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (!(self = [super initWithFrame:frame])) {
        return self;
    }
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake((self.frame.size.width - BUTTON_W) / 2 , 15, BUTTON_W, BUTTON_W);
    [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _addButton.tag = 100;
    [self addSubview:_addButton];
    
    _slider = [[AZCSlider alloc] initWithFrame:CGRectMake((self.frame.size.width - SLIDER_W) / 2, BUTTON_W + 20, SLIDER_W, self.frame.size.height - BUTTON_W * 2 - 25 - 50)];
    _slider.delegate = self;
    [self addSubview:_slider];
    
    _subButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _subButton.frame = CGRectMake((self.frame.size.width - BUTTON_W) / 2 , self.frame.size.height - BUTTON_W - 50, BUTTON_W, BUTTON_W);
    [_subButton setImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
    [_subButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _subButton.tag = 101;
    [self addSubview:_subButton];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 100) / 2, CGRectGetMaxY(_subButton.frame) + 10, 100, BUTTON_W)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor colorWithHexString:@"71757b"];
    _label.text = title;
    [self addSubview:_label];
    return self;
}


- (void)setMinimumValue:(CGFloat)minimumValue {
    _slider.minimumValue = minimumValue;

}

- (void)setMaximumValue:(CGFloat)maximumValue {
    _slider.maximumValue = maximumValue;

}

- (void)setSliderValue:(CGFloat)sliderValue {
    _slider.sliderValue = sliderValue;
}


- (void)slider:(AZCSlider *)slider didSelectValue:(CGFloat)value {
    if ([self.delegate respondsToSelector:@selector(controlView:didSelectValue:)]) {
        [self.delegate controlView:self didSelectValue:value];
    }
}

- (void)click:(UIButton *)sender {
    if (sender.tag == 100) {
        _slider.sliderValue = _slider.sliderValue + 1;
        
    } else {
        _slider.sliderValue = _slider.sliderValue - 1;
    }
    
    if ([self.delegate respondsToSelector:@selector(controlView:didSelectValue:)]) {
        [self.delegate controlView:self didSelectValue:_slider.sliderValue];
    }
    
}


@end
