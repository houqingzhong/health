//
//  YYYSViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "YYYSViewController.h"

#import "HPublic.h"
#import "YYYSSectionView.h"
#import "YYCell.h"
#import "YYTrackCell.h"
#import "HCellPlayer.h"

#define YYCellIdentifier        @"YYCellIdentifier"
#define YY2CellIdentifier       @"YY2CellIdentifier"
#define YYTrackCellIdentifier   @"YYTrackCellIdentifier"

#define YYYSSectionIdentifier @"YYYSSectionIdentifier"

@interface YYYSViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSTimer        *timer;

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
    [_tableView registerClass:[YYTrackCell class] forCellReuseIdentifier:YYTrackCellIdentifier];
    [_tableView registerClass:[YYYSSectionView class] forHeaderFooterViewReuseIdentifier:YYYSSectionIdentifier];
    
    
    
    
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
    
    [_dataArray addObject:@{@"title":@"脏腑养生", @"data":dataArray}];
    
    dataArray = [NSMutableArray new];
    [dataArray addObject:@"平湖秋月"];
    [dataArray addObject:@"催眠曲"];
    [dataArray addObject:@"仲夏夜之梦"];
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"催眠";
    dict[@"data"] = dataArray;
    [_dataArray addObject:dict];

    dataArray = [NSMutableArray new];
    [dataArray addObject:@"创世纪"];
    [dataArray addObject:@"第六交响曲d小调——悲怆"];
    [dataArray addObject:@"第五交响c小调——命运"];
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"解除悲怆";
    dict[@"data"] = dataArray;

    [_dataArray addObject:dict];

    dataArray = [NSMutableArray new];
    [dataArray addObject:@"步步高"];
    [dataArray addObject:@"金蛇狂舞"];
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"振作精神";
    dict[@"data"] = dataArray;

    [_dataArray addObject:dict];

    dataArray = [NSMutableArray new];
    [dataArray addObject:@"梅花三弄"];
    [dataArray addObject:@"塞上曲"];
    [dataArray addObject:@"空山鸟语"];
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"除烦燥";
    dict[@"data"] = dataArray;
    [_dataArray addObject:dict];
    
    dataArray = [NSMutableArray new];
    [dataArray addObject:@"花好月圆"];
    [dataArray addObject:@"青春舞曲"];
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"促进食欲";
    dict[@"data"] = dataArray;
    [_dataArray addObject:dict];

    dataArray = [NSMutableArray new];
    [dataArray addObject:@"平湖秋月"];
    [dataArray addObject:@"雨打芭蕉"];
    [dataArray addObject:@"春江花月夜"];
    [dataArray addObject:@"姑苏行"];
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"降血压";
    dict[@"data"] = dataArray;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self unshceduleProgressTimer];
    
}


- (void)scheduleProgressTimer
{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTrackProgress) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)unshceduleProgressTimer
{
    [self.timer invalidate];
    self.timer = nil;
}


- (void)updateTrackProgress
{
    YYTrackCell *v = (YYTrackCell *)[_tableView dequeueReusableHeaderFooterViewWithIdentifier:YYTrackCellIdentifier];
    [v updateProgress];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSDictionary *dict = _dataArray[section];
    NSArray *dataArray = dict[@"data"];
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = _dataArray[indexPath.section];
    
    HBaseCell *cell = nil;
    if (0 == indexPath.section) {
        NSArray *dataArray = dict[@"data"];
        
        cell = [tableView dequeueReusableCellWithIdentifier:YYCellIdentifier forIndexPath:indexPath];
        
        if (nil == cell) {
            cell = [[YYCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:YYCellIdentifier];
        }
        
        [cell setData:dataArray[indexPath.row]];

        return cell;
    }
    else
    {
        NSDictionary *dict = _dataArray[indexPath.section];
        NSArray *dataArray = dict[@"data"];

        cell = [tableView dequeueReusableCellWithIdentifier:YYTrackCellIdentifier forIndexPath:indexPath];
        if (nil == cell) {
            cell = [[YYTrackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YYTrackCellIdentifier];
        }
        
        [cell setData:@{@"title":dataArray[indexPath.row]}];
        
        [(YYTrackCell *)cell updateAnimation:cell.isSelected];
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        NSDictionary *dict = _dataArray[indexPath.section];
        NSArray *dataArray = dict[@"data"];
        return [YYCell height:dataArray[indexPath.row]];
    }
    else
    {
        return [YYTrackCell height:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100*XA;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = _dataArray[section];
    YYYSSectionView *v = [[YYYSSectionView alloc] initWithReuseIdentifier:YYYSSectionIdentifier];
    [v setData:dict];
    return v;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = _dataArray[indexPath.section];
    NSArray *dataArray = dict[@"data"];
    NSDictionary *dict2 = dataArray[indexPath.row];
    [self jumpToDetail:dict2];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        NSDictionary *dict = _dataArray[indexPath.section];
        NSArray *dataArray = dict[@"data"];
        NSDictionary *dict2 = dataArray[indexPath.row];
        [self jumpToDetail:dict2];
    }
    else
    {
        NSDictionary *dict = _dataArray[indexPath.section];
        NSArray *dataArray = dict[@"data"];

        YYTrackCell *v = (YYTrackCell *)[tableView dequeueReusableCellWithIdentifier:YYTrackCellIdentifier];
        [v play:@{@"title":dataArray[indexPath.row]}];

        [self scheduleProgressTimer];
        
    }
}

- (void)jumpToDetail:(NSDictionary *)dict
{
    
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
