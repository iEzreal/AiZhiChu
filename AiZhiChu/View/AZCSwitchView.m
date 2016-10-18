//
//  AZCSwitchView.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/21.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCSwitchView.h"

@interface AZCSwitchView ()

@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UISwitch *switchButton;

@end

@implementation AZCSwitchView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (!(self = [super initWithFrame:frame])) {
        return self;
    }
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, self.frame.size.height)];
    _nameLabel.textColor = [UIColor colorWithHexString:@"71757b"];
    _nameLabel.font = [UIFont systemFontOfSize:17];
    _nameLabel.text = title;
    [self addSubview:_nameLabel];
    
    // 默认大小
    _switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, (self.frame.size.height - 30) / 2, 50, 30)];
    [_switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_switchButton];
    return self;
}

- (void)switchAction:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(switchView:status:)]) {
        [self.delegate switchView:self status:sender.isOn];
    }
}

- (void)setOn:(BOOL)on {
    _switchButton.on = on;
}

- (BOOL)isOn {
    return _switchButton.on;
}

@end
