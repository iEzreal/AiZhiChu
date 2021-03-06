//
//  设备配对
//
//  AZCDevicePairController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/17.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCDevicePairController.h"
#import "AZCDevicePairSuccessController.h"
#import "AZCDevicePairFailController.h"
#import "AZCDevice.h"

@interface AZCDevicePairController ()<BluetoothManagerDelegate, AZCDevicePairFailReconnectDelegate>

@property(nonatomic, strong) UIImageView *progressBar;
@property(nonatomic, strong) UIImageView *deviceLogo;
@property(nonatomic, strong) UILabel *pairHintLaber;

@end

@implementation AZCDevicePairController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备配对";
    
    [self setupPageSubviews];
    [self layoutPageSubviews];
    [self startAnimation];
    
    [BluetoothManager sharedManager].delegate = self;
    
    if ([BluetoothManager sharedManager].state == 5) {
        [[BluetoothManager sharedManager] startScanPeripheralWithIdentifier:_device.identifier];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [BluetoothManager sharedManager].delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - BluetoothManagerDelegate
- (void)bluetoothChangeState:(NSInteger)state {

}

- (void)deviceConnectResult:(NSError *)error {
    if (!error) {
        [DeviceManager sharedManager].currentDevice = _device;
        AZCDevicePairSuccessController *successController = [[AZCDevicePairSuccessController alloc] init];
        [self.navigationController pushViewController:successController animated:YES];
        
    } else {
        AZCDevicePairFailController *failController = [[AZCDevicePairFailController alloc] init];
        failController.delegate = self;
        [self.navigationController pushViewController:failController animated:YES];
        
    }
    [self stopAnimation];
}

#pragma mark - AZCDevicePairFailReconnectDelegate
- (void)devicePairFailReconnect {
    [self startAnimation];
    [[BluetoothManager sharedManager] startScanPeripheralWithIdentifier:_device.identifier];
}

#pragma mark - 进度条动画
-(void)startAnimation {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.85;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = NSIntegerMax;
    [_progressBar.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)stopAnimation {
    [_progressBar.layer removeAllAnimations];
}

#pragma mark - UI界面
- (void)setupPageSubviews {
    _progressBar = [[UIImageView alloc] init];
    _progressBar.image = [UIImage imageNamed:@"progressbar"];
    [self.view addSubview:_progressBar];
    
    _deviceLogo = [[UIImageView alloc] init];
    _deviceLogo.image = [UIImage imageNamed:@"progressbar_logo"];
    [self.view addSubview:_deviceLogo];
    
    _pairHintLaber = [[UILabel alloc] init];
    _pairHintLaber.textColor = [UIColor colorWithHexString:@"2BA8FD"];
    _pairHintLaber.text = @"正在进行蓝牙配对...";
    [self.view addSubview:_pairHintLaber];
}

- (void)layoutPageSubviews {
    [_progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view);
    }];
    
    [_deviceLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_progressBar);
    }];
    
    [_pairHintLaber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_progressBar.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
    }];
}

@end
