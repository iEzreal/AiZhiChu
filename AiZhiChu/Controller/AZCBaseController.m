//
//  AZHBaseController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/13.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCBaseController.h"

@interface AZCBaseController ()

@end

@implementation AZCBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 30, 30);
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
