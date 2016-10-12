//
//  AZHAcupointController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/15.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCAcupointController.h"
#import "AZCAcupointDetailsController.h"
#import "AZCCommonIllCell.h"

@interface AZCAcupointController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *acupointArray;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation AZCAcupointController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"穴位功效";
    
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
    return [_acupointArray count];
    
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
    commonIllCell.contentLabel.text = [_acupointArray[indexPath.row] objectForKey:@"name"];
    return commonIllCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AZCAcupointDetailsController *detailsController = [[AZCAcupointDetailsController alloc] init];
    detailsController.title = [_acupointArray[indexPath.row] objectForKey:@"name"];
    detailsController.acupointStr = [_acupointArray[indexPath.row] objectForKey:@"image"];
    detailsController.positionStr = [_acupointArray[indexPath.row] objectForKey:@"position"];
    detailsController.functionStr = [_acupointArray[indexPath.row] objectForKey:@"function"];
    [self.navigationController pushViewController:detailsController animated:YES];
}

- (void)loadIllList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pcupoint" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    _acupointArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    if (!_acupointArray) {
        _acupointArray = [[NSArray alloc] init];
    }
}

@end
