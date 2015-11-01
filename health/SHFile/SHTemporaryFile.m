//
//  SHTemporaryFile.m
//  SHFile
//
//  Created by WuShengHua on 5/25/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHTemporaryFile.h"

@interface SHTemporaryFile ()

@end

@implementation SHTemporaryFile

#pragma mark - Directory URL
+ (NSURL *)directoryURL
{
    NSString *directoryPath = [NSTemporaryDirectory() stringByAppendingPathComponent:NSStringFromClass(self)]; // Use class name to create the directory path
    return [NSURL fileURLWithPath:directoryPath isDirectory:YES];
}

#pragma mark - File URL
- (NSURL *)fileURL
{
    return [[SHTemporaryFile directoryURL] URLByAppendingPathComponent:self.fileID];
}

@end
