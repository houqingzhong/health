//
//  HPlayer.h
//  health
//
//  Created by lizhuzhu on 15/10/29.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPlayer : UIView
@property (nonatomic, strong) UILabel           *progressView;
@property (nonatomic, strong) UILabel           *statusLabel;
@property (nonatomic, strong) UIButton          *playButtton;
@property (nonatomic, strong) NSDictionary      *dict;

- (void)setup;
- (void)layout;
+ (CGFloat)height;

- (void)setData:(NSDictionary *)dict;

- (void)scheduleProgressTimer;
- (void)unshceduleProgressTimer;


@end
