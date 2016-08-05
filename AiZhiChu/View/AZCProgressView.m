//
//  AZCProgressView.m
//  AiZhiChu
//
//  Created by Ezreal on 16/7/1.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCProgressView.h"

@interface AZCProgressView ()


@property(nonatomic, strong) UIImageView *progress;
@property(nonatomic, strong) UIImageView *logo;
@property(nonatomic, strong) UILabel *laber;

@end

@implementation AZCProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return self;
    }
    
    return self;
}

- (void)setupPageSubviews {
    _progress = [[UIImageView alloc] init];
    _progress.image = [UIImage imageNamed:@"progressbar"];
    [self addSubview:_progress];
    
    _logo = [[UIImageView alloc] init];
    _logo.image = [UIImage imageNamed:@"progressbar_logo"];
    [self addSubview:_logo];
    
    _laber = [[UILabel alloc] init];
    _laber.textColor = [UIColor colorWithHexString:@"2BA8FD"];
    _laber.text = @"正在进行蓝牙配对...";
    [self addSubview:_laber];
}

- (void)layoutPageSubviews {
    [_progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY);
        make.centerX.equalTo(self);
    }];
    
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_progress);
    }];
    
    [_laber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_progress.mas_bottom).offset(30);
        make.centerX.equalTo(self);
    }];
}




@end
