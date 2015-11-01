//
//  SHDownloader.m
//  SHFile
//
//  Created by WuShengHua on 5/28/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import "SHDownloader.h"

@interface SHDownloader ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation SHDownloader

#pragma mark - Designated initialer
- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

#pragma mark - Fetch data
- (void)fetchDataInBackground:(NSURL *)url handler:(SHDownloaderCompletionHandler)hanlder
{
    [self.queue addOperationWithBlock:^{
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        NSHTTPURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        // Back to the main thread
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (hanlder) {
                if (response.statusCode == 200) {
                    hanlder(data, nil);
                } else {
                    hanlder(nil, error);
                }
            }
        }];
    }];
}

#pragma mark - Suspend and resume
- (void)suspend
{
    self.queue.suspended = YES;
}

- (void)resume
{
    self.queue.suspended = NO;
}

#pragma mark - Cancel
- (void)cancelAll
{
    [self suspend];
    [self.queue cancelAllOperations];
    [self resume];
}

@end
