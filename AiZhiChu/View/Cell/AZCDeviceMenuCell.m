//
//  AZCDeviceMenuCell.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/27.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCDeviceMenuCell.h"

@interface AZCDeviceMenuCell ()

@property(nonatomic, strong) UIImageView *deviceImage;
@property(nonatomic, strong) UIButton *bleMagButton;

@end

@implementation AZCDeviceMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        return self;
    }
    
    [self setupPageSubviews];
    [self layoutPageSubviews];
    
    return self;
}

- (void)setupPageSubviews {
    _deviceImage = [[UIImageView alloc] init];
    _deviceImage.contentMode = UIViewContentModeScaleAspectFill;
    _deviceImage.image = [UIImage imageNamed:@"device_pair"];
    [self.contentView addSubview:_deviceImage];
    
    _deviceName = [[UILabel alloc] init];
    _deviceName.textColor = [UIColor colorWithHexString:@"4C4C4C"];
    _deviceName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_deviceName];
    
    _deviceRemarks = [[UILabel alloc] init];
    _deviceRemarks.textColor = [UIColor colorWithHexString:@"4C4C4C"];
    _deviceRemarks.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_deviceRemarks];
    
    _bleMagButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [_bleMagButton setImage:[UIImage imageNamed:@"bluetooth_icon"] forState:UIControlStateNormal];
    [_bleMagButton setTitleColor:[UIColor colorWithHexString:@"4C4C4C"] forState:UIControlStateNormal];
    [_bleMagButton setTitle:@"已连接" forState:UIControlStateNormal];
    [self.contentView addSubview:_bleMagButton];

}

- (void)layoutPageSubviews {
    [_deviceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.width.height.equalTo(@40);;
    }];
    
    [_deviceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_deviceImage.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-2);
        
    }];
    
    [_deviceRemarks mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_deviceImage.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_centerY).offset(2
                                                              );
    }];
    
    [_bleMagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@30);
    }];
}

@end
