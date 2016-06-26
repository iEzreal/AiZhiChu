//
//  AZHRemoteControlController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/16.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCRemoteControlController.h"
#import "AZCDeviceListController.h"
#import "AZCControlView.h"
#import "AZCSwitchView.h"
#import "AZCDeviceMenuView.h"

@interface AZCRemoteControlController () <AZCControlViewDelegate, AZCSwitchViewDelegate, BluetoothManagerDelegate>

@property(nonatomic, strong)AZCDeviceMenuView *deviceMenuView;

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) AZCControlView *timeView;
@property(nonatomic, strong) AZCControlView *tempView;

@property(nonatomic, strong) AZCSwitchView *switchView;
@property(nonatomic, strong) AZCSwitchView *redlightView;

@property(nonatomic, assign) BOOL isFirstConnect;

@end

@implementation AZCRemoteControlController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"遥控器";
    UIButton *deviceMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deviceMenuButton.frame = CGRectMake(0, 0, 30, 30);
    [deviceMenuButton setImage:[UIImage imageNamed:@"device_menu"] forState:UIControlStateNormal];
    [deviceMenuButton addTarget:self action:@selector(deviceMenuAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deviceMenuButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    [self sutupPageSubviews];
    
    [BluetoothManager  sharedManager].delegate = self;
    [[BluetoothManager sharedManager] readNotifyValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - BluetoothManagerDelegate
- (void)devicePairResult:(NSError *)error {

}
- (void)receiveDeviceNotifyValue:(NSData *)data {
    Byte *value = (Byte *)[data bytes];
    
    // 开关
    if ([DataConversionUtil byte2Int:value[3]] == 0x00) {
        _switchView.on = NO;
    } else {
        _switchView.on = YES;
    }
    
    // 红光 (0x00 -> All LED off) (0x01 -> Red LED on) (0x02 -> Blue LED on) (0x03 -> All on)
    if ([DataConversionUtil byte2Int:value[4]] == 0x01) {
        _redlightView.on = YES;
    } else {
        _redlightView.on = NO;
    }
    
    // 温度
    _tempView.sliderValue = [DataConversionUtil byte2Int:value[5] - 20];
    
    // 时间
    _timeView.sliderValue = [DataConversionUtil byte2Int:value[7]];

    for(int i =0; i < [data length]; i++) {
        NSLog(@"==== 接受的值 ===%hhu", value[i]);
    }
}


#pragma mark - 设备菜单
- (void)deviceMenuAction:(UIButton *)sender {
    if (!_deviceMenuView) {
        _deviceMenuView = [[AZCDeviceMenuView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    }
    if (_deviceMenuView.isShow) {
        [_deviceMenuView dismiss];
        
    } else {
        [_deviceMenuView showWithView:self.view];
    }
}

#pragma mark - AZCControlViewDelegate
- (void)controlView:(AZCControlView *)controlView didSelectValue:(CGFloat)value {
    if (controlView.tag == 1) {
        [self writeDataWithTime:value];
        
    } else {
        [self writeDataWithTemp:value];
    }
}

- (void)writeDataWithTime:(int)time {
    Byte *timeByte = [DataConversionUtil int2Byte:time];
    Byte byte[4];
    byte[0] = 0x01;
    byte[1] = 0x40;
    byte[2] = 0x01;
    byte[3] = timeByte[3];
    int crcInt = [DataConversionUtil crcCheck:byte length:4];
    Byte *crcSesult = [DataConversionUtil int2Byte:crcInt];
    [self writeDataWithCommand:0x40 parameter:byte[3] crc:crcSesult];
}



- (void)writeDataWithTemp:(int)temp {
    Byte *tempByte = [DataConversionUtil int2Byte:(temp + 20)];
    Byte byte[4];
    byte[0] = 0x01;
    byte[1] = 0x30;
    byte[2] = 0x01;
    byte[3] = tempByte[3];
    int crcInt = [DataConversionUtil crcCheck:byte length:4];
    Byte *crcSesult = [DataConversionUtil int2Byte:crcInt];
    [self writeDataWithCommand:0x30 parameter:byte[3] crc:crcSesult];
    
}


#pragma mark - AZCSwitchViewDelegate
- (void)switchView:(AZCSwitchView *)switchView status:(BOOL)status {
    // 0x10：Power
    if (switchView.tag == 100) {
        // 0x00：Power off 0x01：Power on
        if (status) {
            Byte crcSrc[] = {0x01, 0x10, 0x01, 0x01};
            int crcInt = [DataConversionUtil crcCheck:crcSrc length:4];
            Byte *crcSesult = [DataConversionUtil int2Byte:crcInt];
            [self writeDataWithCommand:0x10 parameter:0x01 crc:crcSesult];
            free(crcSesult);
            
        } else {
            Byte crcSrc[] = {0x01, 0x10, 0x01, 0x00};
            int crcInt = [DataConversionUtil crcCheck:crcSrc length:4];
            Byte *crcSesult = [DataConversionUtil int2Byte:crcInt];
            [self writeDataWithCommand:0x10 parameter:0x00 crc:crcSesult];
        
        }
        
    }
    // 0x20：LED
    else {
        if (status) {
            Byte crcSrc[] = {0x01, 0x20, 0x01, 0x01};
            int crcInt = [DataConversionUtil crcCheck:crcSrc length:4];
            Byte *crcSesult = [DataConversionUtil int2Byte:crcInt];
            [self writeDataWithCommand:0x20 parameter:0x01 crc:crcSesult];
        } else {
            Byte crcSrc[] = {0x01, 0x20, 0x01, 0x00};
            int crcInt = [DataConversionUtil crcCheck:crcSrc length:4];
            Byte *crcSesult = [DataConversionUtil int2Byte:crcInt];
            [self writeDataWithCommand:0x20 parameter:0x00 crc:crcSesult];
        }
        
    }
    
}

- (void)writeDataWithCommand:(Byte)commond parameter:(Byte)parameter crc:(Byte *)crc {
    Byte byte[7];
    byte[0] = 0x01;
    byte[1] = commond;
    byte[2] = 0x01;
    byte[3] = parameter;
    byte[4] = crc[3];
    byte[5] = crc[2];
    byte[6] = 0x17;
    
    NSData *data = [NSData dataWithBytes:byte length:7];
    [[BluetoothManager sharedManager] writeData:data];
}

- (void)sutupPageSubviews {
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [self.view addSubview:_bgView];
    
    _timeView = [[AZCControlView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH / 2 - 0.5, 400) title:@"时间(min)"];
    _timeView.backgroundColor = [UIColor colorWithHexString:@"F4F4F4"];
    _timeView.tag = 1;
    _timeView.minimumValue = 0;
    _timeView.maximumValue = 60;
    _timeView.sliderValue = 0;
    _timeView.delegate = self;
    [self.view addSubview:_timeView];
    
    _tempView = [[AZCControlView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 0.5, 64, SCREEN_WIDTH / 2 - 0.5, 400) title:@"温度(℃)"];
    _tempView.backgroundColor = [UIColor colorWithHexString:@"F4F4F4"];
    _tempView.tag = 2;
    _tempView.minimumValue = 0;
    _tempView.maximumValue = 170;
    _tempView.sliderValue = 100;
    _tempView.delegate = self;
    [self.view addSubview:_tempView];
    
    _switchView = [[AZCSwitchView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_timeView
                                                                                   .frame) + 1, SCREEN_WIDTH, 50) title:@"开关"];
    _switchView.backgroundColor = [UIColor whiteColor];
    _switchView.delegate = self;
    _switchView.tag = 100;
    [self.view addSubview:_switchView];
    
    _redlightView = [[AZCSwitchView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_switchView.frame) + 1, SCREEN_WIDTH, 50) title:@"红光"];
    _redlightView.backgroundColor = [UIColor whiteColor];
    _redlightView.delegate = self;
    _redlightView.tag = 101;
    [self.view addSubview:_redlightView];
    _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMinY(_redlightView.frame));
}


@end
