//
//  AZHHomeMenuCell.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/14.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MenuClickBlock)(NSInteger index);

@interface AZCHomeMenuCell : UITableViewCell

@property(nonatomic, copy) MenuClickBlock block;

@end
