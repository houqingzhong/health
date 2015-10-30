//
//  WebViewDetailController.m
//  health
//
//  Created by lizhuzhu on 15/10/29.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "WebViewDetailController.h"
#import "HPublic.h"
#import "HPlayer.h"

@interface WebViewDetailController ()
{
    HPlayer     *_player;
    UIWebView   *_webView;
}
@property (nonatomic, strong) NSDictionary *dict;
@end

@implementation WebViewDetailController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"7.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
        // OS version >= 7.0
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES ;
    }
    
    _webView = [[UIWebView alloc] init];
    _player = [HPlayer new];
    
    
    [self.view addSubview:_player];
    [self.view addSubview:_webView];

    [_player anchorTopLeftWithLeftPadding:0 topPadding:0 width:self.view.width height:[HPlayer height]];
    [_webView alignUnder:_player withLeftPadding:0 topPadding:0 width:self.view.width height:self.view.height - [HPlayer height]];

    [_player setData:_dict];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:_dict[@"html"] ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [_webView loadRequest:request];

}


- (void)loadData:(NSDictionary *)dict
{

    self.dict = dict;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:_dict[@"mp3"] withExtension:nil];
    NSURL *url2 = [[NSBundle mainBundle] URLForResource:_dict[@"mp3-2"] withExtension:nil];
    if (url && url2) {
        NSMutableDictionary *dict_ = [NSMutableDictionary dictionaryWithDictionary:dict];
        dict_[@"mp3"] = (arc4random() % 10/2 == 0 ) ? dict[@"mp3"] : dict[@"mp3-2"];
        self.dict = dict_;
    }
    
}


@end
