//
//  YYYSViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "YYYSViewController.h"

#import "HPublic.h"

#define YYCellIdentifier  @"YYCellIdentifier"

@interface YYYSViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation YYYSViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"7.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
        // OS version >= 7.0
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES ;
    }
    
    self.navigationItem.title = @"音乐养生";
    

    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    [_tableView anchorTopLeftWithLeftPadding:0 topPadding:0 width:CGRectGetWidth(self.view.frame) height:CGRectGetHeight(self.view.frame)];
    
    [self.view addSubview:_tableView];
    
    
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:YYCellIdentifier];
    
    
    
    _dataArray = [NSMutableArray new];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"title"] = @"肝：五脏中的将军";
    dict[@"html"] = @"yyys_liver";
    dict[@"music"] = @"";
    [_dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"心：五脏中的君主";
    dict[@"html"] = @"yyys_heart";
    dict[@"music"] = @"";

    [_dataArray addObject:dict];

    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"脾：五脏中的后勤部长";
    dict[@"html"] = @"yyys_spleen";
    dict[@"music"] = @"";
    [_dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"肺：五脏中的宰相";
    dict[@"html"] = @"yyys_lung";
    dict[@"music"] = @"";
    [_dataArray addObject:dict];
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"肾：五脏中的作强之官";
    dict[@"html"] = @"yyys_kidney";
    dict[@"music"] = @"";
    [_dataArray addObject:dict];
    
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YYCellIdentifier forIndexPath:indexPath];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YYCellIdentifier];
    }
    
    NSDictionary *dict = _dataArray[indexPath.row];
    cell.textLabel.text =dict[@"title"];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60*XA;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self jumpToDetail:indexPath];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self jumpToDetail:indexPath];
}

- (void)jumpToDetail:(NSIndexPath *)indexPath
{
    NSDictionary *dict = _dataArray[indexPath.row];
    
    WebViewDetailController *wc = [WebViewDetailController new];

    [wc loadHtml:dict[@"html"]];
    
    [self.navigationController pushViewController:wc animated:YES];

}


- (void)introView
{
    IntroViewController *iv = [IntroViewController new];
    [iv loadHtml:@"yyys"];
    [self.navigationController pushViewController:iv animated:YES];
}
@end
