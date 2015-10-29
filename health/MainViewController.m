//
//  MainViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "MainViewController.h"

#import "HPublic.h"

#define MainCellIdentifier  @"MainCellIdentifier"
#define HTimerHeader @"HTimerHeader"
@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = nil;
    
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"7.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
        // OS version >= 7.0
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES ;
    }
    
    self.navigationItem.title = @"中医养生";
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor greenMunsell];
    

    
    [_tableView anchorTopLeftWithLeftPadding:0 topPadding:0 width:CGRectGetWidth(self.view.frame) height:CGRectGetHeight(self.view.frame)];
                                                                                                                         
    [self.view addSubview:_tableView];

    
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MainCellIdentifier];
    
    
    
    _dataArray = [NSMutableArray new];
    
    [_dataArray addObject:@""];
    [_dataArray addObject:@""];
    [_dataArray addObject:@""];
    
    
    
}

- (void)viewDidLayoutSubviews
{
    _tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellIdentifier forIndexPath:indexPath];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MainCellIdentifier];
    }
    
    if (0 == indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:@"shichen"];
        cell.textLabel.text = @"时辰养生";
    }
    else if(1 == indexPath.row)
    {
        cell.textLabel.text = @"经络养生";
    }
    else if (2 == indexPath.row)
    {
        cell.textLabel.text = @"音乐养生";
    }

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90*XA;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self jumpToViewController:indexPath];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self jumpToViewController:indexPath];
}

- (void)jumpToViewController:(NSIndexPath *)indexPath
{

    if (0 == indexPath.row) {
     
        [self.navigationController pushViewController:[SCYSViewController new] animated:YES];
    }
    else if (1 == indexPath.row)
    {
        
    }
    else if (2 == indexPath.row) {
        
        [self.navigationController pushViewController:[YYYSViewController new] animated:YES];
    }
    else if (3 == indexPath.row)
    {
        
    }

}
@end
