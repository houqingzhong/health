//
//  JLYSViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/31.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "JLYSViewController.h"
#import "IntroViewController.h"

@interface JLYSViewController ()

@end

@implementation JLYSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"介绍" style:UIBarButtonItemStylePlain target:self action:@selector(introView)];

    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"7.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
        // OS version >= 7.0
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES ;
    }
    
    self.navigationItem.title = @"经络养生";

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)introView
{
    IntroViewController *iv = [IntroViewController new];
    [iv loadHtml:@"jlys"];
    [self.navigationController pushViewController:iv animated:YES];
}
@end
