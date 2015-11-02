//
//  HttpClient.h
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject

+ (void)postDataToServer:(NSString *)strURL path:(NSString *)path callback:(void (^)(NSArray *))callback;

+ (void)getDataFromServer:(NSString *)strURL key:(NSString *)key callback:(void (^)(id))callback;

@end
