//
//  HTypeCell.m
//  health
//
//  Created by lizhuzhu on 15/10/29.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "HTypeCell.h"
#import "HPublic.h"

@interface HTypeCell()
{
    UIImageView *_imgView;
    UILabel *_title;
}
@end

@implementation HTypeCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupUI
{
    
    self.clipsToBounds = YES;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _imgView = [UIImageView new];
    _title = [UILabel new];
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:_imgView];
    [self addSubview:_title];

}

- (void)layout
{
    [_imgView anchorCenterLeftWithLeftPadding:20*XA width:60*XA height:80*XA];
    
    [_title alignToTheRightOf:_imgView matchingCenterWithLeftPadding:20*XA width:self.xMax - _imgView.xMax - 20*XA *2 height:30*XA];
}

- (void)setData:(NSDictionary *)dict
{
    _title.text = dict[@"title"];
    _imgView.image = [UIImage imageNamed:dict[@"icon"]];
}


+(CGFloat)height:(NSDictionary *)dict
{
    
    return 20*XA *2 + 80*XA;
}

@end
