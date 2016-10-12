//
//  AZCNoDeviceView.m
//  AiZhiChu
//
//  Created by Ezreal on 16/10/11.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCNoDeviceView.h"

@interface AZCNoDeviceView ()

@property(nonatomic, strong) UIImageView *logoImageView;
@property(nonatomic, strong) UIView *leftLine;
@property(nonatomic, strong) UIView *rightLine;
@property(nonatomic, strong) UILabel *hintLabel;
@property(nonatomic, strong) UIButton *addDeviceButton;

@end

@implementation AZCNoDeviceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return nil;
    }
    
    [self setupPageViews];
    [self layoutPageViews];
    return self;
}

- (void)addDeviceClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addDeviceAction)]) {
        [self.delegate addDeviceAction];
    }
}

- (void)setupPageViews {
    _logoImageView = [[UIImageView alloc] init];
    _logoImageView.image = [UIImage imageNamed:@"logo"];
    [self addSubview:_logoImageView];
    
    _hintLabel = [[UILabel alloc] init];
    _hintLabel.textColor = [UIColor colorWithHexString:@"929292"];
    _hintLabel.font = [UIFont systemFontOfSize:14];
    _hintLabel.text = @"请添加设备，开启智能生活";
    [self addSubview:_hintLabel];
    
    _leftLine = [[UIView alloc] init];
    _leftLine.backgroundColor = [UIColor colorWithHexString:@"EDEDED"];
    [self addSubview:_leftLine];
    
    _rightLine = [[UIView alloc] init];
    _rightLine.backgroundColor = [UIColor colorWithHexString:@"EDEDED"];
    [self addSubview:_rightLine];
    
    _addDeviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addDeviceButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_addDeviceButton setBackgroundImage:[UIImage imageNamed:@"add_device_normal"] forState:UIControlStateNormal];
    [_addDeviceButton setBackgroundImage:[UIImage imageNamed:@"add_device_selected"] forState:UIControlStateHighlighted];
    [_addDeviceButton setTitleColor:[UIColor colorWithHexString:@"ADD6FF"] forState:UIControlStateNormal];
    [_addDeviceButton setTitleColor:[UIColor colorWithHexString:@"00A8FF"] forState:UIControlStateHighlighted];
    [_addDeviceButton setTitle:@"添加设备" forState:UIControlStateNormal];
    [_addDeviceButton addTarget:self action:@selector(addDeviceClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addDeviceButton];
    
    }

- (void)layoutPageViews {
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).dividedBy(2).offset(32);
    }];
    
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_hintLabel);
        make.left.equalTo(self);
        make.right.equalTo(_hintLabel.mas_left);
        make.height.equalTo(@1);
    }];
    
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_hintLabel);
        make.left.equalTo(_hintLabel.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [_addDeviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_hintLabel.mas_bottom).offset(80);
    }];

}

@end
