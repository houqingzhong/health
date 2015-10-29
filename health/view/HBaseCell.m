//
//  HBaseCell.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "HBaseCell.h"

@interface HBaseCell()

@end

@implementation HBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layout];
}

- (void)layout
{
    
}
- (void)setData:(NSDictionary *)dict
{
    
}

+ (CGFloat)height:(NSDictionary *)dict
{
    
    return 0;
}
@end
