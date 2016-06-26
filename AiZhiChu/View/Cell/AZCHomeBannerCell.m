//
//  AZHHomeBannerCell.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/14.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCHomeBannerCell.h"
#import "CircleBannerView.h"

@interface AZCHomeBannerCell ()

@property(nonatomic, strong) CircleBannerView *bannerView;

@end

@implementation AZCHomeBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        return self;
    }

    _bannerView = [[CircleBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
    _bannerView.styleType = CircleBannerStyleTypeNormal;
    _bannerView.resourceType = CircleBannerResourceTypeLocal;
    _bannerView.imageArray = @[@"home_banner1", @"home_banner2", @"home_banner3"];;
    
    [self.contentView addSubview:_bannerView];

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Configure the view for the selected state
}

@end
