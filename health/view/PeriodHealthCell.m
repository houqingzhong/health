//
//  PeriodHealthCell.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "PeriodHealthCell.h"
#import "HPublic.h"

@interface PeriodHealthCell()
{
    UILabel *_title;
    UILabel *_subTitle;
    
    UILabel *_desc;
}
@end

@implementation PeriodHealthCell

- (void)setupUI
{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _title = [UILabel new];
    _subTitle = [UILabel new];
    _desc = [UILabel new];
    
    _title.textAlignment = NSTextAlignmentCenter;
    _title.backgroundColor = [UIColor greenMunsell];
    
    _title.font = [UIFont systemFontOfSize:28*XA];
    _title.textColor = [UIColor whiteColor];
    
    _subTitle.font = [UIFont systemFontOfSize:28*XA];
    _subTitle.textColor = [UIColor blackOlive];

    _desc.font = [UIFont systemFontOfSize:28*XA];
    _desc.textColor = [UIColor blackOlive];

    
    self.seperator = [UILabel new];
    self.seperator.backgroundColor = [UIColor greenMunsell];
    
    [self addSubview:_title];
    [self addSubview:_subTitle];
    [self addSubview:_desc];
    [self addSubview:self.seperator];
}

- (void)layout
{
    CGFloat left = 20*XA;
    CGFloat top = 20*XA;
    CGFloat width = 120*XA;

    
    CGFloat height = width;
    
    [_title anchorCenterLeftWithLeftPadding:left width:width height:height];
    
    width = CGRectGetWidth(self.frame) - _title.xMax - 2*left;
    CGSize size = [_subTitle contentSizeForWidth:width];
    height = size.height;
    
    [_subTitle alignToTheRightOf:_title withLeftPadding:left topPadding:top width:width height:height];
    
    size = [_desc contentSizeForWidth:width];
    height = size.height;
    [_desc alignUnder:_subTitle matchingLeftAndRightWithTopPadding:top height:height];
    
    width = CGRectGetWidth(self.frame) - _title.xMax - left - left;
    [self.seperator anchorBottomLeftWithLeftPadding:_title.xMax + left bottomPadding:0 width:width height:1*XA];
}

- (void)setData:(NSDictionary *)dict
{
    _title.text = dict[@"sub_title"];
    _subTitle.text = dict[@"title"];
    _desc.text = dict[@"desc"];

 
    [self setNeedsLayout];
}


+ (CGFloat)height:(NSDictionary *)dict
{
    CGFloat left = 20*XA;
    CGFloat top = 20*XA;
    CGFloat width = 120*XA;

    CGFloat cellHeight = top;
    
    width = ScreenSize.width - width - 3*left;
    
    CGSize size = [dict[@"title"] sizeWithFont:[UIFont systemFontOfSize:28*XA] maxSize:CGSizeMake(width, 100*XA)];
    cellHeight += size.height;
    
    cellHeight += top;

    size = [dict[@"desc"] sizeWithFont:[UIFont systemFontOfSize:28*XA] maxSize:CGSizeMake(width, 100*XA)];
    cellHeight += size.height;

    cellHeight += top;
    
    return cellHeight;

}

@end
