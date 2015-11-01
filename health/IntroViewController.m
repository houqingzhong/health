//
//  IntroViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/29.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController()
{
    UIWebView *_webView;
}
@end

@implementation IntroViewController

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

- (void)loadPath:(NSURL *)fileURL
{

    NSURLRequest* request = [NSURLRequest requestWithURL:fileURL] ;
    [_webView loadRequest:request];

}

- (void)loadHTMLString:(NSString *)string
{
    [_webView loadHTMLString:string baseURL:nil];
}

@end
