//
//  SHFile.m
//  SHFile
//
//  Created by WuShengHua on 5/21/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHFile.h"

@interface SHFile ()

@property (nonatomic, strong, readwrite) NSString *fileID;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong) NSData *data;

@end

@implementation SHFile

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_fileID forKey:@"fileID"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_data forKey:@"data"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _fileID = [aDecoder decodeObjectForKey:@"fileID"];
        _name = [aDecoder decodeObjectForKey:@"name"];
        _data = [aDecoder decodeObjectForKey:@"data"];
    }
    
    return self;
}

#pragma mark - Creation
+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data
{
    NSString *fileID = [[NSProcessInfo processInfo] globallyUniqueString];
    SHFile *file = [[self alloc] initWithFileID:fileID];
    file.name = name;
    file.data = data;
    return file;
}

#pragma mark - Designated initializer
- (instancetype)initWithFileID:(NSString *)fileID
{
    self = [super init];
    if (self) {
        _fileID = fileID;
    }
    return self;
}

#pragma mark - Set up and clean up
+ (BOOL)setUp
{
    NSURL *directoryURL = [self directoryURL];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (BOOL)cleanUp
{
    NSURL *directoryURL = [self directoryURL];
    return [[NSFileManager defaultManager] removeItemAtURL:directoryURL error:nil];
}

#pragma mark - Saving
+ (BOOL)saveAll:(NSArray *)files error:(NSError *__autoreleasing *)error
{
    for (SHFile *file in files) {
        if (![file saveData:error]) return NO;
    }
    return YES;
}

- (BOOL)saveData:(NSError *__autoreleasing *)error
{
    if (![self.data length]) return YES;
    
    BOOL success = [self.data writeToURL:[self fileURL] options:NSDataWritingAtomic error:error];
    if (success) self.data = nil;
    
    return success;
}

#pragma mark - Deletion
+ (BOOL)deleteAll:(NSArray *)files error:(NSError *__autoreleasing *)error
{
    for (SHFile *file in files) {
        if (![file deleteData:error]) return NO;
    }
    return YES;
}

- (BOOL)deleteData:(NSError *__autoreleasing *)error
{
    return [[NSFileManager defaultManager] removeItemAtURL:[self fileURL] error:error];
}

#pragma mark - Retrieve data
- (NSData *)retrieveData
{
    if ([self.data length]) return self.data;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *fileURL = [self fileURL];
    if ([fileManager fileExistsAtPath:fileURL.path]) {
        return [NSData dataWithContentsOfURL:fileURL];
    }
    
    return nil;
}

#pragma mark - Abstract method
+ (NSURL *)directoryURL
{
    return nil;
}

- (NSURL *)fileURL
{
    return nil;
}

@end
