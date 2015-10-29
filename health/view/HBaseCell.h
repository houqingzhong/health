//
//  HBaseCell.h
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBaseCell : UITableViewCell

@property (nonatomic, strong) UILabel *seperator;

- (void)setupUI;

- (void)layout;

- (void)setData:(NSDictionary *)dict;

+ (CGFloat)height:(NSDictionary *)dict;

@end
