//
//  TestController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/29.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCDeviceFirstAddController.h"
#import "AZCDeviceListController.h"
#import "AZCDevicePairController.h"

#import "AZCDevicePairSuccessController.h"
#import "AZCRemoteControlController.h"

@interface AZCDevicePairSuccessController ()

@property(nonatomic, strong) UIImageView *successLogo;
@property(nonatomic, strong) UIImageView *deviceLogo;

@property(nonatomic, strong) UIButton *finishButton;

@end

@implementation AZCDevicePairSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配对成功";
    [self setupPageSubviews];
    [self layoutPageSubciews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)finishAction:(UIButton *)sender {
    NSArray *controllers = self.navigationController.viewControllers;
    
    for (UIViewController *vc in controllers) {
        if ([vc isKindOfClass:[AZCRemoteControlController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}

- (void)setupPageSubviews {
    _successLogo = [[UIImageView alloc] init];
    _successLogo.image = [UIImage imageNamed:@"device_pair_success"];
    [self.view addSubview:_successLogo];
    
    _deviceLogo = [[UIImageView alloc] init];
    _deviceLogo.image = [UIImage imageNamed:@"device_pair"];
    [self.view addSubview:_deviceLogo];
    
    _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishButton.layer.cornerRadius = 20;
    _finishButton.layer.masksToBounds = YES;
    [_finishButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"63BBFE"]] forState:UIControlStateNormal];
    [_finishButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"DCDCDD"]] forState:UIControlStateHighlighted];
    [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [_finishButton addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishButton];
}

- (void)layoutPageSubciews {
    [_successLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).multipliedBy(0.5);
    }];
    
    [_deviceLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
        make.width.equalTo(@180);
        make.height.equalTo(@40);
    }];
}

@end
