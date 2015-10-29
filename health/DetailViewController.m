//
//  DetailViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "DetailViewController.h"
#import "HPublic.h"

@interface DetailViewController()
{
    UITextView *_textLabel;
    
}

@property (nonatomic, strong) NSDictionary *dict;
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteSmoke];

    
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    _textLabel = [[UITextView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_textLabel];
    
    
    _textLabel.text = _dict[@"detail"];
    
}

- (void)setData:(NSDictionary *)dict
{
    self.dict = dict;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
