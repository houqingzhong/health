//
//  SHDownloader.h
//  SHFile
//
//  Created by WuShengHua on 5/28/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SHDownloaderCompletionHandler) (NSData *data, NSError *error);

@interface SHDownloader : UIViewController

- (void)fetchDataInBackground:(NSURL *)url handler:(SHDownloaderCompletionHandler)hanlder;

- (void)suspend;
- (void)resume;

- (void)cancelAll;

@end
