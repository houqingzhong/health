//
//  WebViewDetailController.m
//  health
//
//  Created by lizhuzhu on 15/10/29.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "WebViewDetailController.h"

@interface WebViewDetailController ()
{
    UIWebView *_webView;
}
@end

@implementation WebViewDetailController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
    }
    
    return self;
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _webView.frame = self.view.bounds;
}

- (void)loadHtml:(NSString *)fileName
{
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [_webView loadRequest:request];
    
}


@end
