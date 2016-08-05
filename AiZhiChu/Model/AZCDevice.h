//
//  AZCDevice.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/25.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZCDevice : NSObject <NSCoding>

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *minTemp;
@property(nonatomic, strong) NSString *maxTemp;
@property(nonatomic, strong) NSString *remark;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
