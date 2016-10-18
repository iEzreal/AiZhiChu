//
//  AZCDevice.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/25.
//  Copyright © 2016年 上海朴元健康科技有限公司. All rights reserved.
//

#import "AZCDevice.h"

@implementation AZCDevice


- (instancetype)initWithDic:(NSDictionary *)dic {
    if (!(self = [super init])) {
        return nil;
    }
    _name = [dic objectForKey:@"name"];
    _identifier = [dic objectForKey:@"identifier"];
    _image = [dic objectForKey:@"image"];
    _minTemp = [dic objectForKey:@"minTemp"];
    _maxTemp = [dic objectForKey:@"maxTemp"];
    _remark = [dic objectForKey:@"remark"];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super init])) {
        return self;
    }
    _name = [aDecoder decodeObjectForKey:@"name"];
    _identifier = [aDecoder decodeObjectForKey:@"identifier"];
    _image = [aDecoder decodeObjectForKey:@"image"];
    _minTemp = [aDecoder decodeObjectForKey:@"minTemp"];
    _maxTemp = [aDecoder decodeObjectForKey:@"maxTemp"];
    _remark = [aDecoder decodeObjectForKey:@"remark"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_identifier forKey:@"identifier"];
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeObject:_minTemp forKey:@"minTemp"];
    [aCoder encodeObject:_maxTemp forKey:@"maxTemp"];
    [aCoder encodeObject:_remark forKey:@"remark"];
}

@end
