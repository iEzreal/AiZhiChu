//
//  DeviceManager.m
//  AiZhiChu
//
//  Created by Ezreal on 16/6/27.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "DeviceManager.h"

@implementation DeviceManager

static DeviceManager *instance = nil;
+ (DeviceManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (!(self = [super init])) {
        return self;
    }

    return self;
}

- (void)archiveDevices {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_currentDevice forKey:@"device"];
    [archiver finishEncoding];
    BOOL b = [data writeToFile:[self applicationDocumentsDirectoryFile] atomically:YES];
}

- (void)unarchiveDevices {
    NSData *data = [[NSData alloc] initWithContentsOfFile:[self applicationDocumentsDirectoryFile]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    _currentDevice = [unarchiver decodeObjectForKey:@"device"];
    [unarchiver finishDecoding];
}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"device.plist"];
    return path;
}

- (void)setDevice:(AZCDevice *)device {
    _currentDevice = device;
}

@end
