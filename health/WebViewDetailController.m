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
    App(app);
    NSArray *tracks = app.musicData[@"tracks"][@"list"];
    
    __block NSDictionary *track1 = nil;
    __block NSDictionary *track2 = nil;
    [tracks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"title"] isEqualToString:dict[@"mp3"]]) {
            
            track1 = obj;
            
        }
        
        if ([obj[@"title"] isEqualToString:dict[@"mp3-2"]]) {
            track2 = obj;
        }
    }];
    
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    if (track1 && track2) {
        newDict[@"track"] = (arc4random() % 2/2 == 0 ) ? track1 : track2;
        self.dict = newDict;
    }
    else if (track1)
    {
        newDict[@"track"] = track1;
        self.dict = newDict;
    }
    
}


@end
