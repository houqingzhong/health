//
//  WeacherLabel.h
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SmileWeatherCurrentData;

@interface WeacherLabel : UIView

- (void)setData:(NSDictionary *)dict;

+ (CGFloat)height:(NSDictionary *)dict;

@end
