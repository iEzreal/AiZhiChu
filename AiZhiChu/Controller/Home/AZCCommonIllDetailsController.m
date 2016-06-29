//
//  AZHCommonIllDetailsController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/14.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCCommonIllDetailsController.h"
#import "AZCRemoteControlController.h"
#import "AZCIllRegimenPicShowView.h"

@interface AZCCommonIllDetailsController ()

@property(nonatomic, strong) UILabel *noteLabel;
@property(nonatomic, strong) UILabel *noteContentLabel;
@property(nonatomic, strong) UIView *topSplitLine;
@property(nonatomic, strong) UIView *bottomSplitLine;

@property(nonatomic, strong) AZCIllRegimenPicShowView *illRegimenPicShowView;
@property(nonatomic, strong) UIButton *startButton;

@end

@implementation AZCCommonIllDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubviews];
    [self layoutSubviews];
    
    if ([BluetoothManager sharedManager].isConnect) {
        _startButton.enabled = YES;
    } else {
        _startButton.enabled = NO;
    }
}

- (void)startButtonAction {
    AZCRemoteControlController *controller = [[AZCRemoteControlController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)setupSubviews {
    _noteLabel = [[UILabel alloc] init];
    _noteLabel.numberOfLines = 0;
    _noteLabel.textColor = [UIColor colorWithHexString:@"4c4c4c"];
    _noteLabel.font = [UIFont systemFontOfSize:17];
    _noteLabel.text = @"注意事项：";
    [self.view addSubview:_noteLabel];
    
    _topSplitLine = [[UIView alloc] init];
    _topSplitLine.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
    [self.view addSubview:_topSplitLine];
    
    _noteContentLabel = [[UILabel alloc] init];
    _noteContentLabel.numberOfLines = 0;
    _noteContentLabel.textColor = [UIColor colorWithHexString:@"4c4c4c"];
    _noteContentLabel.font = [UIFont systemFontOfSize:15];
    _noteContentLabel.text = _noteContentStr;
    [self.view addSubview:_noteContentLabel];
    
    _bottomSplitLine = [[UIView alloc] init];
    _bottomSplitLine.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
    [self.view addSubview:_bottomSplitLine];
    
    _illRegimenPicShowView = [[AZCIllRegimenPicShowView alloc] init];
    _illRegimenPicShowView.picArray = _picArray;
    [self.view addSubview:_illRegimenPicShowView];
    
    
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"45A3FE"]] forState:UIControlStateNormal];
    _startButton.layer.cornerRadius = 20;
    _startButton.layer.masksToBounds = YES;
    _startButton.titleLabel.textColor = [UIColor whiteColor];
    [_startButton addTarget:self action:@selector(startButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_startButton setTitle:@"启动" forState:UIControlStateNormal];
    [self.view addSubview:_startButton];
}

- (void)layoutSubviews {
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(74);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    [_topSplitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noteLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@1);
    }];
    
    [_noteContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topSplitLine.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    [_bottomSplitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noteContentLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@1);
    }];
    
    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
        make.width.equalTo(@120);
        make.height.equalTo(@40);
    }];
    
    [_illRegimenPicShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomSplitLine.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(_startButton.mas_top).offset(-20);
        
    }];

}


@end
