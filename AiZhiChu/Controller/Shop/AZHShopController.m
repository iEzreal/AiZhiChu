//
//  AZHShopController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/13.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZHShopController.h"

@interface AZHShopController ()

@property(nonatomic, strong) UILabel *label;

@end

@implementation AZHShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    _label = [[UILabel alloc] init];
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:18];
    _label.text = @"该模块暂未实现";
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
