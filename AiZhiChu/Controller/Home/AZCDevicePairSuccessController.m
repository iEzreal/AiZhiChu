//
//  AZCDevicePairSuccesslController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/22.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCDevicePairSuccessController.h"
#import "AZCRemoteControlController.h"

@interface AZCDevicePairSuccessController () <UITextFieldDelegate>

@property(nonatomic, strong) UIImageView *successLogo;
@property(nonatomic, strong) UIImageView *deviceLogo;
@property(nonatomic, strong) UITextField *deviceRemarksTF;

@property(nonatomic, strong) UIButton *finishButton;

@end

@implementation AZCDevicePairSuccessController

- (void)viewDidLoad {
    self.title = @"配对成功";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupPageSubviews];
    [self layoutPageSubciews];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        _finishButton.enabled = NO;
    } else {
        _finishButton.enabled = YES;
    }
}

- (void)finishAction:(UIButton *)sender {
    [DeviceManager sharedManager].currentDevice.remarks = _deviceRemarksTF.text;
    AZCRemoteControlController *controller = [[AZCRemoteControlController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)setupPageSubviews {
    _successLogo = [[UIImageView alloc] init];
    _successLogo.image = [UIImage imageNamed:@"device_pair_success"];
    [self.view addSubview:_successLogo];
    
    _deviceLogo = [[UIImageView alloc] init];
    _deviceLogo.image = [UIImage imageNamed:@"device_pair"];
    [self.view addSubview:_deviceLogo];
    
    _deviceRemarksTF = [[UITextField alloc] init];
    _deviceRemarksTF.textAlignment = NSTextAlignmentCenter;
    _deviceRemarksTF.placeholder = @"点击备注设备名字";
    _deviceRemarksTF.delegate = self;
    [self.view addSubview:_deviceRemarksTF];
    
    _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishButton.layer.cornerRadius = 20;
    _finishButton.layer.masksToBounds = YES;
    [_finishButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"63BBFE"]] forState:UIControlStateNormal];
    [_finishButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"DCDCDD"]] forState:UIControlStateHighlighted];
    [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [_finishButton addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    _finishButton.enabled = NO;
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
    
    [_deviceRemarksTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_deviceLogo.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
        make.width.equalTo(@180);
        make.height.equalTo(@40);
    }];
}

@end
