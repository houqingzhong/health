//
//  SHDocumentsFile.m
//  SHFile
//
//  Created by WuShengHua on 5/25/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHDocumentsFile.h"

@interface SHDocumentsFile ()

@end

@implementation SHDocumentsFile

#pragma mark - Directory URL
+ (NSURL *)directoryURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    // Use class name to create the directory URL
    return [documentsURL URLByAppendingPathComponent:NSStringFromClass(self)];
}

#pragma mark - File URL
- (NSURL *)fileURL
{
    return [[SHDocumentsFile directoryURL] URLByAppendingPathComponent:self.fileID];
}

@end
