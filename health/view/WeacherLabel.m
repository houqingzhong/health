//
//  WeacherLabel.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "WeacherLabel.h"
#import "HPublic.h"

@interface WeacherLabel()
{
    UILabel *_conditionLabel;
}
@end

@implementation WeacherLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _conditionLabel = [UILabel new];
        
        UIFont *font = [UIFont fontWithName:@"Climacons-Font" size:28*XA];
        _conditionLabel.font = font;
        
        [self addSubview:_conditionLabel];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = [_conditionLabel.text sizeWithFont:_conditionLabel.font maxSize:CGSizeMake(300*XA, 300*XA)];
    [_conditionLabel anchorTopRightWithRightPadding:0 topPadding:0 width:size.width height:size.height];
    
}

- (void)setData:(NSDictionary *)dict
{
    _conditionLabel.text = [NSString stringWithFormat:@"%@%@", dict[@"day"], dict[@"condition"]];
    
    [self setNeedsLayout];
}

+ (CGFloat)height:(NSDictionary *)dict
{
    NSString *text = [NSString stringWithFormat:@"%@%@", dict[@"day"], dict[@"condition"]];
    
    CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Climacons-Font" size:28*XA] maxSize:CGSizeMake(300*XA, 300*XA)];

    return size.height;
}
//- (void)getWeaherImage:(NSString *)strWeather
//{
//    if(NSNotFound != [strWeather rangeOfString:@"晴"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@",@"晴.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"多云"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"多云.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"阴"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"阴.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"雨"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"雪"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"小雪.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"雷"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"雷雨.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"雾"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"雾.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"大雪"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"大雪.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"大雨"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"中雪"].location)
//    {
//        fileName = [[NSString alloc]initWithFormat:@"%@",@"中雪.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"中雨"].location)
//    {
//        fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"小雪"].location)
//    {
//        fileName = [[NSString alloc]initWithFormat:@"%@",@"小雪.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"小雨"].location)
//    {
//        fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"雨加雪"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"雨夹雪.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"阵雨"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"雷阵雨"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"雷阵雨.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"大雨转晴"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨转晴.png"];
//    }
//    if(NSNotFound != [strWeather rangeOfString:@"阴转晴"].location)
//    {
//        fileName =[[NSString alloc]initWithFormat:@"%@", @"阴转晴.png"];
//    }
//}
@end
