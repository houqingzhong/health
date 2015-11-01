//
//  JLYSViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/31.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "JLYSViewController.h"
#import "IntroViewController.h"
#import "HPublic.h"
#import "YYTrackCell.h"
#import "HttpClient.h"

#define CellIdentifier  @"CellIdentifier"

@interface JLYSViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray       *dataArray;
@property (nonatomic, strong) UITableView   *tableView;
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [_tableView anchorTopLeftWithLeftPadding:0 topPadding:0 width:CGRectGetWidth(self.view.frame) height:CGRectGetHeight(self.view.frame)];
    
    [self.view addSubview:_tableView];
    
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.navigationItem.title = @"经络养生";

    WS(ws);
    [HttpClient getDataFromServer:[NSString stringWithFormat:@"%@wenzhang/%@", Host, JingLuoTag] key:[JingLuoTag MD5Digest] callback:^(NSArray *dataArray) {
        self.dataArray = dataArray;
        [ws.tableView reloadData];
    }];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dict = _dataArray[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    //[cell setData:_dataArray[indexPath.row]];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = [PeriodHealthCell height:_dataArray[indexPath.row]];
    
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self jumpToDetail:_dataArray[indexPath.row]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self jumpToDetail:_dataArray[indexPath.row]];
}

- (void)jumpToDetail:(NSDictionary *)dict
{
    IntroViewController *iv = [IntroViewController new];
    [iv loadHTMLString:dict[@"content"]];
    [self.navigationController pushViewController:iv animated:YES];
    
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
