//
//  BaseViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/28.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"介绍" style:UIBarButtonItemStylePlain target:self action:@selector(introView)];

}


- (void)introView
{
    
}
@end
