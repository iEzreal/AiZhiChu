//
//  AZHAcupointDetailsController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/16.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCAcupointDetailsController.h"
#import "AZCRemoteControlController.h"

@interface AZCAcupointDetailsController ()

@property(nonatomic, strong) UIImageView *acupointImageView;
@property(nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic, strong) UILabel *acupointPositionLabel;

@property(nonatomic, strong) UILabel *tiaoLiLabel;
@property(nonatomic, strong) UILabel *tiaoLiContentLabel;

@property(nonatomic, strong) UIButton *startButton;


@end

@implementation AZCAcupointDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    if ([BluetoothManager sharedManager].isConnect) {
        _startButton.enabled = YES;
    } else {
        _startButton.enabled = NO;
    }
}

- (void)startButtonAction {
    AZCRemoteControlController *controller = [[AZCRemoteControlController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setupSubviews {
    _acupointImageView = [[UIImageView alloc] init];
    _acupointImageView.contentMode = UIViewContentModeScaleAspectFill;
    _acupointImageView.image = [UIImage imageNamed:_acupointStr];
    [self.view addSubview:_acupointImageView];
    
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.image = [UIImage imageNamed:@"acupoint_dec_bg"];
    [self.view addSubview:_bgImageView];
    
    _acupointPositionLabel = [[UILabel alloc] init];
    _acupointPositionLabel.numberOfLines = 0;
    _acupointPositionLabel.textColor = [UIColor colorWithHexString:@"45627B"];
    _acupointPositionLabel.font = [UIFont systemFontOfSize:14];
    _acupointPositionLabel.text = _positionStr;
    [self.view addSubview:_acupointPositionLabel];
    
    _tiaoLiLabel = [[UILabel alloc] init];
    _tiaoLiLabel.textColor = [UIColor colorWithHexString:@"45627B"];
    _tiaoLiLabel.font = [UIFont systemFontOfSize:18];
    _tiaoLiLabel.text = @"调理功能";
    [self.view addSubview:_tiaoLiLabel];
    
    _tiaoLiContentLabel = [[UILabel alloc] init];
    _tiaoLiContentLabel.numberOfLines = 0;
    _tiaoLiContentLabel.textColor = [UIColor colorWithHexString:@"45627B"];
    _tiaoLiContentLabel.font = [UIFont systemFontOfSize:15];
    _tiaoLiContentLabel.text = _functionStr;
    [self.view addSubview:_tiaoLiContentLabel];

    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"ABE0f6"]] forState:UIControlStateNormal];
    [_startButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"C1C1C1"]] forState:UIControlStateHighlighted];
    _startButton.layer.cornerRadius = 20;
    _startButton.layer.masksToBounds = YES;
    _startButton.titleLabel.textColor = [UIColor whiteColor];
    [_startButton setTitle:@"启动" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(startButtonAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_startButton];

    
    [_acupointImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
    }];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_acupointImageView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(_acupointPositionLabel.mas_bottom).offset(5);
    }];
    
    [_acupointPositionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_acupointImageView.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);

    }];
    
    [_tiaoLiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        
    }];
    
    [_tiaoLiContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tiaoLiLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        
    }];
    
    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
        make.width.equalTo(@120);
        make.height.equalTo(@40);
    }];

    
}

@end
