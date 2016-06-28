//
//  DataConversionUtil.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/26.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (int)byte2Int:(Byte)byte;
+ (Byte *)int2Byte:(int)value;

+ (int)crcCheck:(Byte *)byte length:(int)length;

@end
