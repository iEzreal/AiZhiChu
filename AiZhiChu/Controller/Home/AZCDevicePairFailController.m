//
//  AZCDevicePairFailController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/22.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCDevicePairFailController.h"
#import "AZCHomeController.h"


@interface AZCDevicePairFailController ()

@property(nonatomic, strong) UIImageView *failLogo;
@property(nonatomic, strong) UILabel *failLabel;
@property(nonatomic, strong) UIButton *pairButton;

@end

@implementation AZCDevicePairFailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备配对失败";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.tag = 10;
    backButton.frame = CGRectMake(0, 0, 30, 30);
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [self setupPageSubviews];
    [self layoutPageSubviews];
}

- (void)clickAction:(UIButton *)sender {
    if (sender.tag == 10) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[AZCHomeController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(devicePairFailReconnect)]) {
            [self.delegate devicePairFailReconnect];
        }
        [self.navigationController popViewControllerAnimated:self];
    }
}

- (void)setupPageSubviews {
    _failLogo = [[UIImageView alloc] init];
    _failLogo.image = [UIImage imageNamed:@"device_pair_fail"];
    [self.view addSubview:_failLogo];
    
    _failLabel = [[UILabel alloc] init];
    _failLabel.textColor = [UIColor colorWithHexString:@"A2A2A2"];
    _failLabel.text = @"配对失败";
    [self.view addSubview:_failLabel];
    
    _pairButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _pairButton.tag = 11;
    _pairButton.layer.cornerRadius = 20;
    _pairButton.layer.masksToBounds = YES;
    [_pairButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"63BBFE"]] forState:UIControlStateNormal];
    [_pairButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"DCDCDD"]] forState:UIControlStateHighlighted];
    [_pairButton setTitle:@"重新配对" forState:UIControlStateNormal];
    [_pairButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pairButton];
}

- (void)layoutPageSubviews {
    
    [_failLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(140);
    }];
    
    [_failLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_failLogo.mas_bottom).offset(15);
    }];
    
    [_pairButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
        make.width.equalTo(@160);
        make.height.equalTo(@40);
    }];
}


@end
