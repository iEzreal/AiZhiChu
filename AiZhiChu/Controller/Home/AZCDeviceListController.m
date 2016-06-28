//
//  AZCSelectDeviceController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/17.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCDeviceListController.h"
#import "AZCDevicePairController.h"
#import "AZCDeviceCell.h"

@interface AZCDeviceListController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *deviceArray;

@end

@implementation AZCDeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的设备";
    
    [self loadDeviceList];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadDeviceList {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"devices" ofType:@"plist"];
    _deviceArray = [NSArray arrayWithContentsOfFile:plistPath];
    if (!_deviceArray) {
        _deviceArray = [[NSArray array] init];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _deviceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"AZCDeviceCell";
    AZCDeviceCell *deviceCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!deviceCell) {
        deviceCell = [[AZCDeviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        deviceCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    deviceCell.deviceImage.image = [UIImage imageNamed:[_deviceArray[indexPath.row] objectForKey:@"image"]];
    deviceCell.deviceName.text = [_deviceArray[indexPath.row] objectForKey:@"name"];
    return deviceCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AZCDevicePairController *controlller = [[AZCDevicePairController alloc] init];
    controlller.deviceName = [_deviceArray[indexPath.row] objectForKey:@"name"];
    [self.navigationController pushViewController:controlller animated:YES];
}

@end
