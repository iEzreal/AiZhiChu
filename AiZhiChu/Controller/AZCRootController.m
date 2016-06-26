//
//  AZHRootController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/13.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCRootController.h"
#import "AZCNavigationController.h"
#import "AZCHomeController.h"
#import "AZHShopController.h"
#import "AZHConsultController.h"
#import "AZCMineController.h"

@interface AZCRootController ()

@end

@implementation AZCRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupChildController {
    [self addChildController:[[AZCHomeController alloc] init] title:@"首页" image:@"home_normal" selectedImage:@"home_selected"];
    [self addChildController:[[AZHShopController alloc] init] title:@"商城" image:@"shop_normal" selectedImage:@"shop_selected"];
    [self addChildController:[[AZHConsultController alloc] init] title:@"咨询" image:@"consult_normal" selectedImage:@"consult_selected"];
    [self addChildController:[[AZCMineController alloc] init] title:@"我" image:@"mine_normal" selectedImage:@"mine_selected"];
}

- (void)addChildController:(UIViewController *)controller
                     title:(NSString *)title
                     image:(NSString *)image
             selectedImage:(NSString *)selectedImage {
    
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"4C4C4C"]} forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"45A2FF"]} forState:UIControlStateSelected];
    
    AZCNavigationController *navController = [[AZCNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:navController];
}




@end
