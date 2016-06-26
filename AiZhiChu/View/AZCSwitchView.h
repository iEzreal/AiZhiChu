//
//  AZCSwitchView.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/21.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZCSwitchView;
@protocol AZCSwitchViewDelegate <NSObject>

- (void)switchView:(AZCSwitchView *)switchView status:(BOOL)status;

@end

@interface AZCSwitchView : UIView

@property(nonatomic, getter=isOn) BOOL on;

@property(nonatomic, weak) id<AZCSwitchViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@end
