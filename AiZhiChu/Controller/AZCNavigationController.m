//
//  AZCNavigationController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/17.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCNavigationController.h"

@interface AZCNavigationController ()

@end

@implementation AZCNavigationController


+(void)initialize{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:[UIColor grayColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:NavigationBarTitleColor]}];
    
    //自定义返回按钮
    UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
   
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor colorWithHexString:NavigationBarColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
