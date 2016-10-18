//
//  AZHHomeMenuCell.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/14.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCHomeMenuCell.h"

@interface AZCHomeMenuCell ()

@property(nonatomic, strong)UIView *bgView;

@property(nonatomic, strong) NSArray *menuArray;

@end

@implementation AZCHomeMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        return self;
    }
    
    _menuArray = [[NSArray alloc] init];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 2) / 3 * 2 + 2)];
    _bgView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [self.contentView addSubview:_bgView];
    
    
    NSArray *imageArray = @[@"home_menu_regimen", @"home_menu_manual", @"home_menu_remot",
                            @"home_menu_moxibustion", @"home_menu_video", @"home_menu_other"];
    NSArray *titleArray = @[@"养生所", @"产品说明", @"遥控器",
                            @"艾灸产品", @"宣传片", @"其他"];
    
    // 总共6个 分3列
    for (int i = 0; i < 6; i++) {
        long rowIndex = i / 3;
        long columnIndex = i % 3;
        CGFloat x = (SCREEN_WIDTH - 2) / 3 * columnIndex + columnIndex * 1;
        CGFloat y = (SCREEN_WIDTH - 2) / 3 * rowIndex + rowIndex * 1;
        ImageTextButton *menuItem = [[ImageTextButton alloc] initWithFrame:CGRectMake(x, y, (SCREEN_WIDTH - 2) / 3, (SCREEN_WIDTH - 2) / 3) image:[UIImage imageNamed:imageArray[i]] title:titleArray[i]];
        menuItem.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentUp;
        [menuItem setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [menuItem setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"e5e5e5"]] forState:UIControlStateHighlighted];
        [menuItem setTitleColor:[UIColor colorWithHexString:@"4C4C4C"] forState:UIControlStateNormal];
        menuItem.tag = i;
        [menuItem addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:menuItem];
    }
    
    return self;
}

- (void)click:(UIButton *)sender {
    if (self.block) {
        self.block(sender.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
