//
//  DataConversionUtil.h
//  AiZhiChu
//
//  Created by Ezreal on 16/6/26.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZCUtil : NSObject

+ (Byte *)int2Byte:(int)value;
+ (int)byte2Int:(Byte)byte;
+ (int)crcCheck:(Byte *)byte length:(int)length;

+ (void)showWithStatus:(NSString *)status;
+ (void)showHintWithStatus:(NSString *)status duration:(NSTimeInterval)duration;
+ (void)showErrorWithStatus:(NSString *)status duration:(NSTimeInterval)duration;
+ (void)showSuccessWithStatus:(NSString *)status duration:(NSTimeInterval)duration;
+ (void)dismissProgressHUD;


@end
