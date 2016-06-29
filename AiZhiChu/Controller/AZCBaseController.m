//
//  AZHBaseController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/13.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCBaseController.h"

@interface AZCBaseController ()

@end

@implementation AZCBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
