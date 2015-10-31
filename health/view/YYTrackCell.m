//
//  YYTrackCell.m
//  health
//
//  Created by lizhuzhu on 15/10/31.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "YYTrackCell.h"
#import "HPublic.h"
#import "HCellPlayer.h"
#import "NavPlayButton.h"

@interface YYTrackCell()
{
    UILabel         *_titleLabel;
    NavPlayButton   *_statusButton;
}
@property (nonatomic, strong) HCellPlayer   *playerView;
@property (nonatomic, strong) NSDictionary  *dict;
@end

@implementation YYTrackCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLabel = [UILabel new];
        _playerView = [HCellPlayer new];
        //_statusButton = [NavPlayButton new];
        
        [self addSubview:_titleLabel];
        [self addSubview:_playerView];
        [self addSubview:_statusButton];
        
        _playerView.alpha = 0;

        
    }
    return self;
}

- (void)layout
{
    [super layout];
    
    [_titleLabel anchorCenterLeftWithLeftPadding:20*XA width:self.width/2 height:30];
    
    //[_playerView alignToTheRightOf:_titleLabel withLeftPadding:20*XA topPadding:0 width:self.width-_titleLabel.width height:self.height];

    [_statusButton anchorCenterRightWithRightPadding:20*XA width:60*XA height:60*XA];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (CGFloat)height:(NSDictionary *)dict
{
    
    return 100*XA;
    
}


- (void)setData:(NSDictionary *)dict
{
    
    App(app);
    
    _titleLabel.text = dict[@"title"];
    
    NSArray *tracks = app.musicData[@"tracks"][@"list"];
    
    __block NSDictionary *track = nil;
    [tracks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"title"] isEqualToString:dict[@"title"]]) {
            track = obj;
        }
    }];
    
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    if (track) {
        newDict[@"track"] = track;
    }
    
    self.dict = newDict;
    
    
//    [self updateAnimation];

    [self setNeedsLayout];
    
}

- (void)play:(NSDictionary *)dict
{
    [self setData:dict];

    [_playerView play:self.dict];
    
    [self updateAnimation:YES];
    
    [self setNeedsLayout];

    
}

- (void)updateProgress
{
    [self setNeedsLayout];
}

- (void)updateAnimation:(BOOL)show
{
    if (show) {
        [_statusButton startAnimation];
        _statusButton.hidden = NO;
    }
    else
    {
        [_statusButton stopAnimation];
        _statusButton.hidden = YES;
    }

}

@end
