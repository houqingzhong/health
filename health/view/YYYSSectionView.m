//
//  YYYSSectionView.m
//  health
//
//  Created by lizhuzhu on 15/10/30.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "YYYSSectionView.h"
#import "HPublic.h"
#import "HCellPlayer.h"

@interface YYYSSectionView()
{
    UILabel     *_titleLabel;
}

@property (nonatomic, strong) NSDictionary *dict;
@end

@implementation YYYSSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor greenMunsell];
        
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:30*XA];
        _titleLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:_titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = [_titleLabel contentSizeForWidth:self.width /3];
    
    [_titleLabel anchorCenterLeftWithLeftPadding:20*X_OK width:size.width height:size.height];
    
}

- (void)setData:(NSDictionary *)dict
{
    _titleLabel.text = dict[@"title"];
    
    self.dict = dict;
    [self setNeedsLayout];
}

- (BOOL)contained:(NSString *)title
{
    __block BOOL flag = NO;
    NSArray *dataArray = _dict[@"data"];
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:title]) {
            flag = YES;
            *stop = YES;
        }
    }];
    
    return flag;
}

@end
