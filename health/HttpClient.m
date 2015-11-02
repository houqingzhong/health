//
//  HttpClient.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "HttpClient.h"
#import "HPublic.h"
#import <AFNetworking.h>

@interface HttpClient()

@property(strong,nonatomic)NSString *intString;

@end

@implementation HttpClient

+ (HttpClient *)sharedInstance {
    static HttpClient *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)getWeatherData
{
    //解析网址通过ip 获取城市天气代码
    NSURL *url = [NSURL URLWithString:@"http://61.4.185.48:81/g/"];
    
    //定义一个NSError对象，用于捕获错误信息
    NSError *error;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"------------%@",jsonString);
    
    // 得到城市代码字符串，截取出城市代码
    NSString *Str;
    for (int i = 0; i<=[jsonString length]; i++)
    {
        for (int j = i+1; j <=[jsonString length]; j++)
        {
            Str = [jsonString substringWithRange:NSMakeRange(i, j-i)];
            if ([Str isEqualToString:@"id"]) {
                if (![[jsonString substringWithRange:NSMakeRange(i+3, 1)] isEqualToString:@"c"]) {
                    _intString = [jsonString substringWithRange:NSMakeRange(i+3, 9)];
                    NSLog(@"***%@***",_intString);
                }
            }
        }
    }
    
    //中国天气网解析地址；
    NSString *path=@"http://m.weather.com.cn/data/cityNumber.html";
    //将城市代码替换到天气解析网址cityNumber 部分！
    path=[path stringByReplacingOccurrencesOfString:@"cityNumber" withString:_intString];
    
    NSLog(@"path:%@",path);

}

+ (void)postDataToServer:(NSString *)strURL path:(NSString *)path callback:(void (^)(NSArray *))callback
{

    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSString *content = [AESCrypt encrypt:dataString password:@"wenzhang&19851010&yangsheng"];
//    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:strURL parameters:@{@"content_id":@"3867"} constructingBodyWithBlock:^(id formData) {
        [formData appendPartWithFormData:data name:@"content"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *ret = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", ret);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


+ (void)getDataFromServer:(NSString *)strURL key:(NSString *)key callback:(void (^)(id))callback
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = nil;
    [manager GET:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        if ([dict[@"code"] integerValue] == 0) {
            
//            NSArray *arr = dict[@"data"];
            
//            NSMutableArray *newArr = [NSMutableArray new];
//            for (NSDictionary *dict_ in arr) {
//                NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:dict_];
//                NSString *title = dict_[@"title"];
//                NSString *content = [dict_[@"content"] JSONString];
//                //content = [AESCrypt decrypt:content password:@"wenzhang&19851010&yangsheng"];
//                NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
//                SHDocumentsFile *file = [SHDocumentsFile fileWithName:[NSString stringWithFormat:@"%@.html", title] data:data];
//                NSError *error = nil;
//                [file saveData:&error];
//                newDict[@"file"] = file;
//                
//                [newArr addObject:newDict];
//            }
            
            if (callback) {
                callback(dict[@"data"]);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(nil);
        }
    }];
}

//+ (void)getWenzhang:(NSString *)strURL callback:(void (^)(BOOL))callback
//{
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = nil;
//    [manager GET:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dict = (NSDictionary *)responseObject;
//        if ([dict[@"code"] integerValue] == 0) {
//            
//            for (NSDictionary *dict_ in dict[@"data"]) {
//                NSString *title = dict_[@"title"];
//                NSString *content = dict_[@"content"];
//                content = [AESCrypt decrypt:content password:@"wenzhang&19851010&yangsheng"];
//                NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
//                SHDocumentsFile *file = [SHDocumentsFile fileWithName:[NSString stringWithFormat:@"%@.html", title] data:data];
//                NSError *error = nil;
//                [file saveData:&error];
//            }
//            
//            if (callback) {
//                callback(YES);
//            }
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (callback) {
//            callback(NO);
//        }
//    }];
//}


@end

