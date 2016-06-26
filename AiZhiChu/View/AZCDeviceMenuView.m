//
//  AZCDeviceMenuView.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/21.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCDeviceMenuView.h"

#define GAP_RIGHT 80

@interface AZCDeviceMenuView () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *contentView;

@property(nonatomic, strong) UIButton *addDeviceButton;
@property(nonatomic, strong) UIButton *deleteDeviceButton;

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation AZCDeviceMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return self;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0;
    [_bgView addGestureRecognizer:tapGesture];
    [self addSubview:_bgView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(GAP_RIGHT - self.frame.size.width, 0, self.frame.size.width - GAP_RIGHT, self.frame.size.height)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    _addDeviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addDeviceButton.frame = CGRectMake(10, 10, 40, 40);
    [_addDeviceButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_contentView addSubview:_addDeviceButton];
    
    _deleteDeviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteDeviceButton.frame = CGRectMake(_contentView.frame.size.width - 50, 10, 40, 40);
    [_deleteDeviceButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [_contentView addSubview:_deleteDeviceButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width - GAP_RIGHT, self.frame.size.height) style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_contentView addSubview:_tableView];
    
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPat {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
    }
    
}



- (void)tapGesture:(UITapGestureRecognizer *)sender {
    [self dismiss];
}

- (void)showWithView:(UIView *)superView {
    [superView addSubview:self];
    _isShow = true;
    [UIView animateWithDuration:0.35 animations:^{
         _bgView.alpha = 0.5;
        _contentView.frame = CGRectMake(0, 0, self.frame.size.width - GAP_RIGHT, self.frame.size.height);
    }];
}

- (void)dismiss {
    
    _isShow = false;
    [UIView animateWithDuration:0.35 animations:^{
        _bgView.alpha = 0;
        _contentView.frame = CGRectMake(GAP_RIGHT - self.frame.size.width, 0, self.frame.size.width - GAP_RIGHT, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}


@end
