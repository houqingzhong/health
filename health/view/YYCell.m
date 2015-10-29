//
//  YYCell.m
//  health
//
//  Created by lizhuzhu on 15/10/29.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "YYCell.h"

#import "HPublic.h"

@interface YYCell()
{
    UILabel *_title;
    UILabel *_subTitle;
}
@end

@implementation YYCell

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)setupUI
{
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _subTitle = [UILabel new];
    _subTitle.font = [UIFont systemFontOfSize:24*XA];
    
    _title = [UILabel new];
    _title.font = [UIFont systemFontOfSize:28*XA];
    
    [self addSubview:_subTitle];
    [self addSubview:_title];
    
}

- (void)layout
{
    
    [_title anchorTopLeftWithLeftPadding:20*XA topPadding:20*XA width:self.xMax - 20*XA*2 height:[UIFont systemFontOfSize:28*XA].lineHeight];
    
    [_subTitle alignUnder:_title matchingLeftWithTopPadding:20*XA width:self.xMax - 20*XA*2 height:[UIFont systemFontOfSize:24*XA].lineHeight];
    
}

- (void)setData:(NSDictionary *)dict
{
    _title.text = dict[@"title"];
    _subTitle.text = dict[@"sub_title"];
}


+(CGFloat)height:(NSDictionary *)dict
{

    CGFloat cellHeight = [UIFont systemFontOfSize:28*XA].lineHeight;
    cellHeight += [UIFont systemFontOfSize:24*XA].lineHeight;
    
    cellHeight += 20*XA *3;
    
    return cellHeight;
    
}

@end
