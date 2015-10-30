//
//  JLViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "SCYSViewController.h"

#import "HPublic.h"

#define CellIdentifier  @"CellIdentifier"

@interface SCYSViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SCYSViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"十二时辰养生";

//    self.navigationItem.rightBarButtonItem = nil;

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
    
    
    [_tableView registerClass:[PeriodHealthCell class] forCellReuseIdentifier:CellIdentifier];
    
    
    
    _dataArray = [NSMutableArray new];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"title"] = @"21:00-23:00 三焦经";
    dict[@"sub_title"] = @"亥时";
    dict[@"html"] = @"scys_haishi";
    dict[@"mp3"] = @"平沙落雁.m4a";
    dict[@"mp3-2"] = @"忆故人.mp3";
    dict[@"desc"] = @"亥时百脉通，养身养娇容。";
    dict[@"detail"] = @"此时三焦经最旺。三焦是六腑中最大的腑，具备主持诸气，疏通水路的作用，亥时三焦通百脉，人如果在亥时深度睡眠，百脉可休息生息，对身板十分有益，百岁老人有个共同独特之处，即亥时困觉，故此时段内睡觉最佳，易于第二日起床后精神倍好。";
    
    [_dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"23:00-1:00 胆经";
    dict[@"sub_title"] = @"子时";
    dict[@"desc"] = @"子时睡得足，黑眼圈不露。";
    dict[@"html"] = @"scys_zishi";
    dict[@"detail"] = @"此时胆经最旺摄生学认为：\"肝之余气，泻于胆，聚而成精胆为中正之官，五脏六腑决定于胆气以壮胆，邪不能侵胆气虚则怯，气短，谋虑而不能决断\"因而可知胆的重要性。有些人等闲切除患者的胆，是不负责的表现。胆汁需要新陈代谢，人在子时前入睡，胆方能完成代谢。\"胆有多清，脑有多清\"，凡在子时前入睡者，晨醒后脑筋清楚，精神和面红润。反之，子时前不睡者，精神和面清白出格是胆汁缺乏新陈代谢的气而变浓结晶，形成结石，犹如海水变浓晒成盐此中一部门人还会是以而\"胆怯\"胆经这时要上床困觉，利于骨髓造血。";
    [_dataArray addObject:dict];
    
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"1:00-3:00 肝经";
    dict[@"sub_title"] = @"丑时";
    dict[@"html"] = @"scys_choushi";
    dict[@"desc"] = @"丑时不睡晚，脸上不长斑。";
    dict[@"detail"] = @"此时肝经最旺，\"肝藏血\"，人的思维和行动要靠肝血撑持，废旧的血液裁减，新颖的血液孕育发生，这类代谢都是在肝经最旺的丑时完成。摄生学认为：\"人卧则血归于肝\"。若丑时未入睡的话，肝还在输出能量，就无法完成新陈代谢。所以丑时前未入睡者，脸色青灰，情志倦怠而焦躁，易生肝病。肝经最旺的丑时是肝脏修复的最佳时段。";
    [_dataArray addObject:dict];
    
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"3:00-5:00 肺经";
    dict[@"sub_title"] = @"寅时";
    dict[@"html"] = @"scys_yinshi";
    dict[@"desc"] = @"寅时睡得熟，面红精气足。";
    dict[@"detail"] = @"此时肺经最旺，\"肺朝百脉\"，肝于丑时推陈出新，将新颖血液提供给肺，经由肺送往全身。因此，人在早晨脸色红润，精神抖擞。寅时，有肺病的人反映尤为强烈。肺经呼吸运作最佳的时候，而此时脉搏最弱。";
    [_dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"5:00-7:00 大肠经";
    dict[@"sub_title"] = @"卯时";
    dict[@"html"] = @"scys_maoshi";
    dict[@"mp3"] = @"潇湘水云.m4a";
    dict[@"mp3-2"] = @"梅花三弄.m4a";
    dict[@"desc"] = @"卯时大肠蠕，排毒渣滓出。";
    dict[@"detail"] = @"此时大肠经最旺，\"肺与大肠相表里\"，肺将充足的新颖血液布满全身，紧接着促进大肠经步入兴奋状况，完成对食品中水分与营养的吸收，排出渣滓。这时起床，大肠蠕动旺盛，适合排泻。";
    [_dataArray addObject:dict];
    
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"7:00-9:00 胃经";
    dict[@"sub_title"] = @"辰时";
    dict[@"html"] = @"scys_chenshi";
    dict[@"mp3"] = @"洞庭秋思.m4a";
    dict[@"mp3-2"] = @"山居吟.m4a";    
    dict[@"desc"] = @"辰时吃早餐，营养身体安。";
    dict[@"detail"] = @"此时胃经最旺，在7:00过后吃早餐最容易消化。如果胃火过盛，表现为嘴唇干，重则豁嘴或生疮。胃经胃最活跃，此时一定吃早餐，每一天这时敲胃经最佳，开始工作人体的发电系统。";
    [_dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"9:00-11:00 脾经";
    dict[@"sub_title"] = @"巳时";
    dict[@"html"] = @"scys_sishi";
    dict[@"mp3"] = @"高山.m4a";
    dict[@"mp3-2"] = @"阳春.m4a";
    dict[@"desc"] = @"巳时脾经旺，造血身体壮。";
    dict[@"detail"] = @"此时脾经最旺，\"脾主运化，脾统血\"，脾是消化，吸收，排泄的总调度，又是人体血液的统领。\"脾开窍于口，其华在唇\"。脾的功效好，表现为消化吸收好，血的质量好，嘴唇红润。唇白标志血气不足，唇暗，唇紫标志寒入脾经。";
    [_dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"11:00-13:00 心经";
    dict[@"sub_title"] = @"午时";
    dict[@"html"] = @"scys_wushi";
    dict[@"mp3"] = @"乌夜啼.m4a";
    dict[@"mp3-2"] = @"雉朝飞.mp3";
    dict[@"desc"] = @"午时一小憩，安神养精气。";
    dict[@"detail"] = @"此时心经最旺，\"心主神明，开窍于舌，其华在表\"。心气鞭策血液运行、养神、养气、养筋。人在中午能小睡片刻，对于养心大有益，可以使乃至晚上精神抖擞。心经此时保养表情舒服，适当休息或午睡。";
    [_dataArray addObject:dict];
    
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"13:00-15:00 小肠经";
    dict[@"sub_title"] = @"未时";
    dict[@"html"] = @"scys_weishi";
    dict[@"mp3"] = @"列子御风.m4a";
    dict[@"mp3-2"] = @"庄周梦蝶.m4a";
    dict[@"desc"] = @"未时分清浊，饮水降虚火。";
    dict[@"detail"] = @"此时小肠经最旺。小肠分清浊，把水液归入膀胱，糟粕送入大肠，精华上输至脾。未时是小肠最活跃的时候，故午餐应在下午1时前吃。";
    [_dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"15:00-17:00 膀胱经";
    dict[@"sub_title"] = @"申时";
    dict[@"mp3"] = @"白雪.m4a";
    dict[@"mp3-2"] = @"长清.m4a";
    dict[@"html"] = @"scys_shenshi";
    dict[@"desc"] = @"申时津液足，养阴身体舒。";
    dict[@"detail"] = @"此时膀胱经最旺，膀胱储藏水液和津液，轮回水液并将骈枝部分排出体外。津液在体内轮回，若膀胱有热，可致膀胱咳，咳而夜尿证。膀胱经膀胱最活跃的时候，适当多喝水。";
    [_dataArray addObject:dict];
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"17:00-19:00 肾经";
    dict[@"sub_title"] = @"酉时";
    dict[@"html"] = @"scys_youshi";
    dict[@"mp3"] = @"流水.m4a";
    dict[@"mp3-2"] = @"鹤鸣九皋.m4a";
    dict[@"desc"] = @"酉时肾藏精，纳华元气清。";
    dict[@"detail"] = @"此时肾经最旺，\"肾藏于生殖之精，肾为天赋和五脏六腑之精之根\"。人体经过申时泄火排毒，肾在酉时步入储藏精华的阶段。肾经适合休息。";
    [_dataArray addObject:dict];
    
    
    dict = [NSMutableDictionary new];
    dict[@"title"] = @"19:00-21:00 心包经";
    dict[@"sub_title"] = @"戌时";
    dict[@"html"] = @"scys_xushi";
    dict[@"mp3"] = @"文王操.m4a";
    dict[@"desc"] = @"戌时护心脏，减压心舒畅。";
    dict[@"detail"] = @"此时心包经最旺，\"心包为心之外膜，附有脉络，是气血通行之道邪不能容，容之心伤\"。心包是心的保护组织，又是气血运行的通道。心包经戌时行旺，可断根心脏周围外邪，使心脏处于无缺状况。心包经旺时宜随便走走，这时心脑颅神经器官系统最活跃，心脏欠好的人最好这时候敲心包经，成效最佳。";
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
    
    PeriodHealthCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (nil == cell) {
        cell = [[PeriodHealthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    [cell setData:_dataArray[indexPath.row]];
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
    if (dict[@"html"] && dict[@"mp3"]) {
        WebViewDetailController *iv = [WebViewDetailController new];
        [iv loadData:dict];
        [self.navigationController pushViewController:iv animated:YES];
    }
    else if(dict[@"html"])
    {
        IntroViewController *iv = [IntroViewController new];
        [iv loadHtml:dict[@"html"]];
        [self.navigationController pushViewController:iv animated:YES];

    }
    else
    {
        DetailViewController *detail = [DetailViewController new];
        [detail setData:dict];
        
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    
}

- (void)introView
{
    IntroViewController *iv = [IntroViewController new];
    [iv loadHtml:@"scys"];
    [self.navigationController pushViewController:iv animated:YES];
}
@end
