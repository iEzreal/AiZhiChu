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
@property(nonatomic, strong) NSString *remarks;
@property(nonatomic, strong) NSString *imageURL;

@end
