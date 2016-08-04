//
//  AZCDeviceMenuView.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/21.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCDeviceMenuView.h"
#import "AZCDeviceMenuCell.h"
#import "AZCDevice.h"

#define GAP_RIGHT 80

@interface AZCDeviceMenuView ()

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *contentView;

@property(nonatomic, strong) UIButton *addDeviceButton;
@property(nonatomic, strong) UIButton *deleteDeviceButton;

@property(nonatomic, strong) UIView *deviceView;
@property(nonatomic, strong) UIImageView *deviceImage;
@property(nonatomic, strong) UILabel *deviceName;
@property(nonatomic, strong) UILabel *deviceRemarks;
@property(nonatomic, strong) UILabel *deviceState;
@property(nonatomic, strong) UIButton *deleteButton;

@property(nonatomic, assign) BOOL isDeleteState;


@end

@implementation AZCDeviceMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return self;
    }
    
    [self setupPageSubviews];
    
    return self;
}

#pragma mark - 菜单按钮操作
- (void)deviceManagerAction:(UIButton *)sender {
    // 添加设备操作
    if (sender.tag == 100) {
        if ([self.delegate respondsToSelector:@selector(addDevice)]) {
            [self.delegate addDevice];
        }
    }
    // 显示删除按钮
    else if (sender.tag == 101){
        CGRect deviceViewRect = _deviceView.frame;
        CGRect deleteBtnRect = _deleteButton.frame;
        if (_isDeleteState) {
            _isDeleteState = false;
            [UIView animateWithDuration:0.3 animations:^{
                _deviceView.frame = CGRectMake(0, deviceViewRect.origin.y, deviceViewRect.size.width, deviceViewRect.size.height);
                _deleteButton.frame = CGRectMake(_contentView.frame.size.width, deleteBtnRect.origin.y, 0, deleteBtnRect.size.height);
                
            } completion:^(BOOL finished) {
                
            }];

        } else {
            _isDeleteState = true;
            [UIView animateWithDuration:0.3 animations:^{
                _deviceView.frame = CGRectMake(-60, deviceViewRect.origin.y, deviceViewRect.size.width, deviceViewRect.size.height);;
                _deleteButton.frame = CGRectMake(_contentView.frame.size.width - 60, deleteBtnRect.origin.y, 60, deleteBtnRect.size.height);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    // 删除当前设备
    else {
        if ([self.delegate respondsToSelector:@selector(deleteDevice)]) {
            [self.delegate deleteDevice];
            [self deleteDeviceInfo];
        }
    }
}

- (void)deleteDeviceInfo{
    _deviceName.text = @"";
    _deviceRemarks.text = @"";
    _deviceState.text = @"";
    _deleteDeviceButton.enabled = NO;
    _deviceView.hidden = YES;
    _deleteButton.hidden = YES;
}

- (void)updateDeviceWith:(AZCDevice *)device {
    if (device) {
        _deviceName.text = device.name;
        _deviceRemarks.text = device.remarks;
        _deleteDeviceButton.enabled = YES;
        _deviceView.hidden = NO;
        _deleteButton.hidden = NO;
    } else {
        _deleteDeviceButton.enabled = NO;
        _deviceView.hidden = YES;
        _deleteButton.hidden = YES;

    }
}

- (void)updateDeviceState:(BOOL)state {
    if (state) {
        _deviceState.text = @"已连接";
    } else {
        _deviceState.text = @"未连接";
    }
}

#pragma mark - 菜单显示和关闭
- (void)showWithView:(UIViewController *)superController {
    _superController = superController;
    _isShow = true;
    [superController.view addSubview:self];
    [UIView animateWithDuration:0.35 animations:^{
         _bgView.alpha = 0.5;
        _contentView.frame = CGRectMake(0, 0, self.frame.size.width - GAP_RIGHT, self.frame.size.height);
    }];
}

- (void)dismiss {
    _isShow = false;
    [UIView animateWithDuration:0.35 animations:^{
        _bgView.alpha = 0;
        _contentView.frame = CGRectMake(GAP_RIGHT - self.frame.size.width, 0, self.frame.size.width - GAP_RIGHT, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)tapGesture:(UITapGestureRecognizer *)sender {
    [self dismiss];
}

#pragma mark - UI控件
- (void)setupPageSubviews {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0;
    [_bgView addGestureRecognizer:tapGesture];
    [self addSubview:_bgView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(GAP_RIGHT - self.frame.size.width, 0, self.frame.size.width - GAP_RIGHT, self.frame.size.height)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    _addDeviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addDeviceButton.frame = CGRectMake(10, 10, 40, 40);
    [_addDeviceButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addDeviceButton addTarget:self action:@selector(deviceManagerAction:) forControlEvents:UIControlEventTouchUpInside];
    _addDeviceButton.tag = 100;
    [_contentView addSubview:_addDeviceButton];
    
    _deleteDeviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteDeviceButton.frame = CGRectMake(_contentView.frame.size.width - 50, 10, 40, 40);
    [_deleteDeviceButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [_deleteDeviceButton addTarget:self action:@selector(deviceManagerAction:) forControlEvents:UIControlEventTouchUpInside];
    _deleteDeviceButton.tag = 101;
    [_contentView addSubview:_deleteDeviceButton];
    
    
    // 设备信息
    _deviceView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_addDeviceButton.frame) + 10, _contentView.frame.size.width, 60)];
    _deviceView.backgroundColor = [UIColor colorWithHexString:@"EFEFF0"];
    [_contentView addSubview:_deviceView];
    
    _deviceImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    _deviceImage.contentMode = UIViewContentModeScaleAspectFill;
    _deviceImage.image = [UIImage imageNamed:@"device_pair"];
    [_deviceView addSubview:_deviceImage];
    
    _deviceName = [[UILabel alloc] init];
    _deviceName.frame = CGRectMake(CGRectGetMaxX(_deviceImage.frame) + 10, 10, 120, 20);
    _deviceName.textColor = [UIColor colorWithHexString:@"4C4C4C"];
    _deviceName.font = [UIFont systemFontOfSize:14];
    [_deviceView addSubview:_deviceName];
    
    _deviceRemarks = [[UILabel alloc] init];
    _deviceRemarks.frame = CGRectMake(CGRectGetMaxX(_deviceImage.frame) + 10, CGRectGetMaxY(_deviceName.frame), 120, 20);
    _deviceRemarks.textColor = [UIColor colorWithHexString:@"4C4C4C"];
    _deviceRemarks.font = [UIFont systemFontOfSize:14];
    [_deviceView addSubview:_deviceRemarks];
    
    _deviceState = [[UILabel alloc] init];
    _deviceState.frame = CGRectMake(_deviceView.frame.size.width - 60, 15, 60, 30);
    _deviceState.textColor = [UIColor colorWithHexString:@"4C4C4C"];
    _deviceState.font = [UIFont systemFontOfSize:14];
    [_deviceView addSubview:_deviceState];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _deleteButton.backgroundColor = [UIColor redColor];
    _deleteButton.frame = CGRectMake(_contentView.frame.size.width, CGRectGetMinY(_deviceView.frame), 0, 60);
    [_deleteButton setImage:[UIImage imageNamed:@"delete_ble"] forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(deviceManagerAction:) forControlEvents:UIControlEventTouchUpInside];
    _deleteButton.tag = 104;
    [_contentView addSubview:_deleteButton];
}


@end
