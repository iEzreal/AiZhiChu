//
//  AZCDevice.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/25.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCDevice.h"

@implementation AZCDevice

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (!(self = [super init])) {
        return self;
    }
    _name = [aDecoder decodeObjectForKey:@"name"];
    _remarks = [aDecoder decodeObjectForKey:@"remarks"];
    _imageURL = [aDecoder decodeObjectForKey:@"imageURL"];
    _isConnect = [aDecoder decodeObjectForKey:@"isConnect"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_remarks forKey:@"remarks"];
    [aCoder encodeObject:_imageURL forKey:@"imageURL"];
    [aCoder encodeObject:_isConnect forKey:@"isConnect"];

}

@end
