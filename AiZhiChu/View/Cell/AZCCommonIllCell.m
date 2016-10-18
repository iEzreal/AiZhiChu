//
//  AZHCommonIllCell.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/14.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCCommonIllCell.h"

@interface AZCCommonIllCell ()

@property(nonatomic, strong) UIImageView *bgView;

@end

@implementation AZCCommonIllCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        return self;
    }
    
    _bgView = [[UIImageView alloc] init];
    _bgView.contentMode = UIViewContentModeScaleAspectFill;
    _bgView.image = [UIImage imageNamed:@"circle"];
    [self.contentView addSubview:_bgView];
    
    _numLabel = [[UILabel alloc] init];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.layer.masksToBounds = YES;
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_numLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor colorWithHexString:@"4c4c4c"];
    _contentLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_contentLabel];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(_numLabel.mas_height);
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_numLabel);
        make.width.height.equalTo(_numLabel.mas_width);
    }];
   
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numLabel.mas_right).offset(15);
        make.centerY.equalTo(self.contentView);
    }];

    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
