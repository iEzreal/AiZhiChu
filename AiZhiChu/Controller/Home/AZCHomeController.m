//
//  AZHHomeController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/13.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCHomeController.h"
#import "AZCRegimenController.h"
#import "AZCRemoteControlController.h"
#import "AZCDeviceFirstAddController.h"

#import "AZCHomeBannerCell.h"
#import "AZCHomeMenuCell.h"

@interface AZCHomeController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation AZCHomeController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(-20, 0, 49, 0));
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 230;

    } else {
        return (SCREEN_WIDTH - 2) / 3 * 2 + 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Banner cell
    if (indexPath.row == 0) {
        static NSString *bannerCellIdentifier = @"AZHHomeBannerCell";
        AZCHomeBannerCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:bannerCellIdentifier];
        if (!bannerCell) {
            bannerCell = [[AZCHomeBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bannerCellIdentifier];
        }
        return bannerCell;
    }
    
    // Menu cell
    else {
        static NSString *menuCellIdentifier = @"AZHHomeMenuCell";
        AZCHomeMenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier];
        if (!menuCell) {
            menuCell = [[AZCHomeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCellIdentifier];
        }
        __weak typeof(self) weakself = self;
        menuCell.block = ^(NSInteger index){
            if (index == 0) {
                [weakself redirectWithController:[[AZCRegimenController alloc] init]];
                
            } else if (index == 2) {
                [weakself redirectToRemoteControl];
            } else {
                
                [AZCUtil showHintWithStatus:@"功能开发中" duration:3];
            }
        };
        return menuCell;
    }
}

- (void)redirectToRemoteControl {
    if ([BluetoothManager sharedManager].state == 5) {
        AZCRemoteControlController *controller = [[AZCRemoteControlController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
            
    } else {
        [AZCUtil showHintWithStatus:@"蓝牙不可用" duration:3];
    }
}

- (void)redirectWithController:(UIViewController *)controller {
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
