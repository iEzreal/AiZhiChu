//
//  AZCDeviceCell.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/17.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCDeviceCell.h"

@interface AZCDeviceCell ()

@property(nonatomic, strong) UILabel *bluetoothLabel;

@end

@implementation AZCDeviceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        return self;
    }
    
    _deviceImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_deviceImage];
    
    _deviceName = [[UILabel alloc] init];
    _deviceName.textColor = [UIColor colorWithHexString:@"4C4C4C"];
    _deviceName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_deviceName];
    
    _bluetoothLabel = [[UILabel alloc] init];
    _bluetoothLabel.textColor = [UIColor colorWithHexString:@"4C4C4C"];
    _bluetoothLabel.font = [UIFont systemFontOfSize:14];
    _bluetoothLabel.text = @"蓝牙连接";
    [self.contentView addSubview:_bluetoothLabel];

    
    [_deviceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    [_deviceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_deviceImage.mas_right).offset(10);
    }];
    
    [_bluetoothLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-3);
    }];

    
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
