//
//  DataConversionUtil.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/26.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "AZCUtil.h"

@implementation AZCUtil

+ (int)byte2Int:(Byte)byte {
    return byte & 0xff;
}

// 高位在前，低位在后
+ (Byte *)int2Byte:(int)value {
    Byte *byte = malloc(4);
    byte[0] = (Byte) ((value >> 24) & 0xFF);
    byte[1] = (Byte) ((value >> 16) & 0xFF);
    byte[2] = (Byte) ((value >> 8) & 0xFF);
    byte[3] = (Byte) (value & 0xFF);
    return byte ;
}

+ (int)crcCheck:(Byte *)byte length:(int)length{
    int wCrc = 0xffff;
    for (int i = 0; i < length; i++) {
        int data = [self byte2Int:byte[i]];
        for (int j = 0; j < 8; j++) {
            if ((((wCrc & 0x8000) >> 8) ^ ((data << j) & 0x80)) != 0) {
                wCrc = (wCrc << 1) ^ 0x1021;
            } else {
                wCrc = wCrc << 1;
            }
        }
    }
    wCrc = (wCrc << 8) | (wCrc >> 8 & 0xff);
    return wCrc & 0xffff;

}

@end