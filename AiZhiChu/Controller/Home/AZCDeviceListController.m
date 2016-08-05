//
//  AZCSelectDeviceController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/17.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCDeviceListController.h"
#import "AZCDevicePairController.h"
#import "AZCDeviceListCell.h"

@interface AZCDeviceListController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *deviceArray;

@end

@implementation AZCDeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的设备";
    
    _deviceArray = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self loadDeviceList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadDeviceList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"devices" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    for (int i = 0; i < array.count; i++) {
        AZCDevice *device = [[AZCDevice alloc] initWithDic:array[i]];
        [_deviceArray addObject:device];
    }
    
    [_tableView reloadData];
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
    AZCDeviceListCell *deviceCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!deviceCell) {
        deviceCell = [[AZCDeviceListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        deviceCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    AZCDevice *device = _deviceArray[indexPath.row];
    deviceCell.deviceImage.image = [UIImage imageNamed:device.image];
    deviceCell.deviceName.text = device.name;
    return deviceCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AZCDevicePairController *controlller = [[AZCDevicePairController alloc] init];
    controlller.device = _deviceArray[indexPath.row];
    [self.navigationController pushViewController:controlller animated:YES];
}

@end
