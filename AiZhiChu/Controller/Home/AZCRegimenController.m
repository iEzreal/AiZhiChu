//
//  AZHRegimenController.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/14.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCRegimenController.h"
#import "AZCCommonIllController.h"
#import "AZCAcupointController.h"


@interface AZCRegimenController ()

@property(nonatomic, strong) UIButton *illButton;
@property(nonatomic, strong) UILabel *illLabel;
@property(nonatomic, strong) UIButton *acupointButton;
@property(nonatomic, strong) UILabel *acupointLabel;

@end

@implementation AZCRegimenController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"养生所";
    
    _illButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_illButton setImage:[UIImage imageNamed:@"common_ill"] forState:UIControlStateNormal];
    [_illButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_illButton];
    
    _illLabel = [[UILabel alloc] init];
    _illLabel.textColor = [UIColor colorWithHexString:@"4c4c4c"];
    _illLabel.font = [UIFont systemFontOfSize:16];
    _illLabel.text = @"常见病";
    [self.view addSubview:_illLabel];
    
    _acupointButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_acupointButton setImage:[UIImage imageNamed:@"acupoint_funtion"] forState:UIControlStateNormal];
    [_acupointButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_acupointButton];
    
    _acupointLabel = [[UILabel alloc] init];
    _acupointLabel.textColor = [UIColor colorWithHexString:@"4c4c4c"];
    _acupointLabel.font = [UIFont systemFontOfSize:16];
    _acupointLabel.text = @"穴位功效";
    [self.view addSubview:_acupointLabel];
    
    [_illButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).offset(-80);
        
    }];

    [_illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_illButton.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        
    }];
    
    [_acupointButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_centerY).offset(80);
        
    }];
    
    [_acupointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_acupointButton.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        
    }];

}

- (void)click:(UIButton *)sender {
    if ([sender isEqual:_illButton]) {
        AZCCommonIllController *controller = [[AZCCommonIllController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        AZCAcupointController *acupointController = [[AZCAcupointController alloc] init];
        [self.navigationController pushViewController:acupointController animated:YES];
    }
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
