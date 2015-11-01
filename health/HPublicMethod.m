//
//  HPublicMethod.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "HPublicMethod.h"
#import "HPublic.h"

@implementation HPublicMethod

+ (void)saveDataToLocal:(id)obj key:(NSString *)key
{
    if (obj && key) {
        App(app);
        [app.localStore putObject:obj withId:key intoTable:server_data_cahce];
    }
    
}

+ (id)getLocalData:(NSString *)key
{
    if (key) {
        App(app);
        id obj = [app.localStore getObjectById:key fromTable:server_data_cahce];
        return obj;
    }
    
    return nil;
}

+ (NSString *)getPeriodName
{
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSHourCalendarUnit fromDate:date];
    
    NSString *text = nil;
    NSInteger hour  =[components hour];
    if (hour >= 23 || hour < 1) {
        text = @"子时";
    }
    else if (hour >= 1 && hour < 3) {
        text = @"丑时";
    }
    else if (hour >= 3 && hour < 5) {
        text = @"寅时";
    }
    else if (hour >= 5 && hour < 7) {
        text = @"卯时";
    }
    else if (hour >= 7 && hour < 9) {
        text = @"辰时";
    }
    else if (hour >= 9 && hour < 11) {
        text = @"巳时";
    }
    else if (hour >= 11 && hour < 13) {
        text = @"午时";
    }
    else if (hour >= 13 && hour < 15) {
        text = @"未时";
    }
    else if (hour >= 15 && hour < 17) {
        text = @"申时";
    }
    else if (hour >= 17 && hour < 19) {
        text = @"酉时";
    }
    else if (hour >= 19 && hour < 21) {
        text = @"戌时";
    }
    else if (hour >= 21 && hour < 23) {
        text = @"亥时";
    }
    
    return text;
}

+ (UIImage *)getWeatherImage:(NSString *)strWeather
{
    NSString *fileName = nil;
    if(NSNotFound != [strWeather rangeOfString:@"晴"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@",@"晴.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"多云"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"多云.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"阴"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"阴.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雨"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雪"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"小雪.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雷"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"雷雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雾"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"雾.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"大雪"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"大雪.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"大雨"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"中雪"].location)
    {
        fileName = [[NSString alloc]initWithFormat:@"%@",@"中雪.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"中雨"].location)
    {
        fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"小雪"].location)
    {
        fileName = [[NSString alloc]initWithFormat:@"%@",@"小雪.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"小雨"].location)
    {
        fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雨加雪"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"雨夹雪.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"阵雨"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"雷阵雨"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"雷阵雨.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"大雨转晴"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨转晴.png"];
    }
    if(NSNotFound != [strWeather rangeOfString:@"阴转晴"].location)
    {
        fileName =[[NSString alloc]initWithFormat:@"%@", @"阴转晴.png"];
    }
    
    if (fileName) {
        return [UIImage imageNamed:fileName];
    }
    
    return nil;

}
@end
