//
//  AZHLaunchController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/16.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCLaunchController.h"
#import "AZCRootController.h"
#import "AppDelegate.h"

@interface AZCLaunchController ()

@property(nonatomic, strong) UIImageView *logoImageView;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UIButton *registerButton;

@end

@implementation AZCLaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _logoImageView = [[UIImageView alloc] init];
    _logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:_logoImageView];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_normal"] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_selected"] forState:UIControlStateHighlighted];
    [_loginButton setTitleColor:[UIColor colorWithHexString:@"4C4C4C"] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor colorWithHexString:@"45A2FF"] forState:UIControlStateHighlighted];
    [_loginButton setTitle:@"进入" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.tag = 1;
    [self.view addSubview:_loginButton];
    
    _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerButton setBackgroundImage:[UIImage imageNamed:@"login_normal"] forState:UIControlStateNormal];
    [_registerButton setBackgroundImage:[UIImage imageNamed:@"login_selected"] forState:UIControlStateHighlighted];
    [_registerButton setTitleColor:[UIColor colorWithHexString:@"4C4C4C"] forState:UIControlStateNormal];
    [_registerButton setTitleColor:[UIColor colorWithHexString:@"45A2FF"] forState:UIControlStateHighlighted];
    [_registerButton setTitle:@"进入" forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    _registerButton.tag = 2;
    [self.view addSubview:_registerButton];

    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).multipliedBy(0.5);
        
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).multipliedBy(1.25).offset(50);
        make.centerX.equalTo(self.view).offset(-50);
        make.width.height.equalTo(@60);
        
    }];
    
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).multipliedBy(1.25).offset(50);
        make.centerX.equalTo(self.view).offset(50);
        make.width.height.equalTo(_loginButton);

    }];
    
}

- (void)onClick:(UIButton *)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = [[AZCRootController alloc] init];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
