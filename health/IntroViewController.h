//
//  IntroViewController.h
//  health
//
//  Created by lizhuzhu on 15/10/29.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface IntroViewController : BaseViewController

- (void)loadHtml:(NSString *)fileName;

- (void)loadPath:(NSURL *)fileURL;

- (void)loadHTMLString:(NSString *)string;

- (void)loadHTMLWithContentId:(NSString *)contentId;
@end
