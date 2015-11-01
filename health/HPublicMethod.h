//
//  HPublicMethod.h
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPublicMethod : NSObject

+ (UIImage *)getWeatherImage:(NSString *)strWeather;

+ (NSString *)getPeriodName;

+ (id)getLocalData:(NSString *)key;
+ (void)saveDataToLocal:(id)obj key:(NSString *)key;

@end
