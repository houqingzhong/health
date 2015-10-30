//
//  YYYSViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "YYYSViewController.h"

#import "HPublic.h"
#import "YYCell.h"

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"介绍" style:UIBarButtonItemStylePlain target:self action:@selector(introView)];
    
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"7.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
        // OS version >= 7.0
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES ;
    }
    
    self.navigationItem.title = @"音乐养生";
    

    _dataArray = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor greenMunsell];

    
    
    [_tableView anchorTopLeftWithLeftPadding:0 topPadding:0 width:CGRectGetWidth(self.view.frame) height:CGRectGetHeight(self.view.frame)];
    
    [self.view addSubview:_tableView];
    
    
    
    [_tableView registerClass:[YYCell class] forCellReuseIdentifier:YYCellIdentifier];
    
    
    
    NSMutableArray *dataArray = [NSMutableArray new];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"title"] = @"养肝";
    dict[@"sub_title"] = @"肝者，将军之官，谋虑出焉。";
    dict[@"html"] = @"yyys_liver";
    dict[@"mp3"] = @"胡笳十八拍";
    [dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"养心";
    dict[@"sub_title"] = @"心者，君主之官也，神明出焉。";
    dict[@"html"] = @"yyys_heart";
    dict[@"mp3"] = @"紫竹调";

    [dataArray addObject:dict];

    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"养脾";
    dict[@"sub_title"] = @"脾胃者，仓廪之官，五味出焉。";
    dict[@"html"] = @"yyys_spleen";
    dict[@"mp3"] = @"十面埋伏";
    [dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"养肺";
    dict[@"sub_title"] = @"肺者，相傅之官，治节出焉。";
    dict[@"html"] = @"yyys_lung";
    dict[@"mp3"] = @"阳春白雪";
    [dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"养肾";
    dict[@"sub_title"] = @"肾者，作强之官，伎巧出焉。";
    dict[@"html"] = @"yyys_kidney";
    dict[@"mp3"] = @"梅花三弄";
    [dataArray addObject:dict];
    
    [_dataArray addObject:dataArray];
    
    dataArray = [NSMutableArray new];
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"催眠";
    dict[@"html"] = @"yyys_kidney";
    dict[@"mp3"] = @"[平湖秋月, 梦幻曲, 催眠曲, 仲夏夜之梦]";
    
//    [_dataArray addObject:dataArray];

}

- (void)viewDidLayoutSubviews
{
    _tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSArray *dataArray = _dataArray[section];
    
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *dataArray = _dataArray[indexPath.section];
    
    YYCell *cell = [tableView dequeueReusableCellWithIdentifier:YYCellIdentifier forIndexPath:indexPath];
    
    if (nil == cell) {
        cell = [[YYCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:YYCellIdentifier];
    }
        
    [cell setData:dataArray[indexPath.row]];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *dataArray = _dataArray[indexPath.section];
    return [YYCell height:dataArray[indexPath.row]];
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
    NSArray *dataArray = _dataArray[indexPath.section];
    NSDictionary *dict = dataArray[indexPath.row];
    
    WebViewDetailController *wc = [WebViewDetailController new];

    [wc loadData:dict];
    
    [self.navigationController pushViewController:wc animated:YES];

}

- (void)introView
{
    IntroViewController *iv = [IntroViewController new];
    [iv loadHtml:@"yyys"];
    [self.navigationController pushViewController:iv animated:YES];
}
@end
