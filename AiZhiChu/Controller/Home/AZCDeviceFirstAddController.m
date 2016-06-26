//
//  AZCDeviceAddController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/22.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCDeviceFirstAddController.h"
#import "AZCDeviceListController.h"

@interface AZCDeviceFirstAddController ()

@property(nonatomic, strong) UIImageView *logoImageView;
@property(nonatomic, strong) UIView *leftLine;
@property(nonatomic, strong) UIView *rightLine;
@property(nonatomic, strong) UILabel *hintLabel;
@property(nonatomic, strong) UIButton *addDeviceButton;


@end

@implementation AZCDeviceFirstAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"遥控器";
    [self setupPageSubview];
    [self layoutPageSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupPageSubview {
    _logoImageView = [[UIImageView alloc] init];
    _logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:_logoImageView];
    
    _hintLabel = [[UILabel alloc] init];
    _hintLabel.textColor = [UIColor colorWithHexString:@"929292"];
    _hintLabel.font = [UIFont systemFontOfSize:14];
    _hintLabel.text = @"请添加设备，开启智能生活";
    [self.view addSubview:_hintLabel];
    
    _leftLine = [[UIView alloc] init];
    _leftLine.backgroundColor = [UIColor colorWithHexString:@"EDEDED"];
    [self.view addSubview:_leftLine];
    
    _rightLine = [[UIView alloc] init];
    _rightLine.backgroundColor = [UIColor colorWithHexString:@"EDEDED"];
    [self.view addSubview:_rightLine];
    
    _addDeviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addDeviceButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_addDeviceButton setBackgroundImage:[UIImage imageNamed:@"add_device_normal"] forState:UIControlStateNormal];
    [_addDeviceButton setBackgroundImage:[UIImage imageNamed:@"add_device_selected"] forState:UIControlStateHighlighted];
    [_addDeviceButton setTitleColor:[UIColor colorWithHexString:@"ADD6FF"] forState:UIControlStateNormal];
    [_addDeviceButton setTitleColor:[UIColor colorWithHexString:@"00A8FF"] forState:UIControlStateHighlighted];
    [_addDeviceButton setTitle:@"添加设备" forState:UIControlStateNormal];
    [_addDeviceButton addTarget:self action:@selector(addDeviceClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addDeviceButton];
}

- (void)layoutPageSubview {
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view.mas_centerY).dividedBy(2).offset(32);
    }];
    
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_hintLabel);
        make.left.equalTo(self.view);
        make.right.equalTo(_hintLabel.mas_left);
        make.height.equalTo(@1);
    }];
    
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_hintLabel);
        make.left.equalTo(_hintLabel.mas_right);
        make.right.equalTo(self.view);
        make.height.equalTo(@1);
    }];
    
    [_addDeviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_hintLabel.mas_bottom).offset(80);
    }];
}

- (void)addDeviceClick:(UIButton *)sender {
    AZCDeviceListController *selectController = [[AZCDeviceListController alloc] init];
    [self.navigationController pushViewController:selectController animated:YES];

}



@end
