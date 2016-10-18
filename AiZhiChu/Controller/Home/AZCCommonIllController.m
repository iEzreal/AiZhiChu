//
//  AZHCommonIllController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/14.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCCommonIllController.h"
#import "AZCCommonIllDetailsController.h"
#import "AZCCommonIllCell.h"

@interface AZCCommonIllController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *illArray;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation AZCCommonIllController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常见病";
    
    [self loadIllList];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_illArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"AZHCommonIllCell";
    AZCCommonIllCell *commonIllCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!commonIllCell) {
        commonIllCell = [[AZCCommonIllCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        commonIllCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    commonIllCell.numLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    commonIllCell.contentLabel.text = [_illArray[indexPath.row] objectForKey:@"illName"];
    return commonIllCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AZCCommonIllDetailsController *detailsController = [[AZCCommonIllDetailsController alloc] init];
    detailsController.title = [_illArray[indexPath.row] objectForKey:@"illName"];
    detailsController.noteContentStr = [_illArray[indexPath.row] objectForKey:@"illNote"];
    detailsController.picArray = [_illArray[indexPath.row] objectForKey:@"illPic"];
    [self.navigationController pushViewController:detailsController animated:YES];
}

- (void)loadIllList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"illList" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    _illArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    if (!_illArray) {
        _illArray = [[NSArray alloc] init];
    }
}


@end
