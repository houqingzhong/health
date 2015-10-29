//
//  HPlayer.m
//  health
//
//  Created by lizhuzhu on 15/10/29.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "HPlayer.h"
#import "HPublic.h"

@interface HPlayer()<APAudioPlayerDelegate>
{
    UIButton        *_playButtton;
    UIProgressView        *_progressView;
    UILabel         *_timeLeft;
    UILabel         *_timeRight;
    
}
/* Timer */
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSDictionary *dict;
@end

@implementation HPlayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _progressView = [UIProgressView new];
        [self addSubview:_progressView];
        
        
        _timeLeft = [UILabel new];
        [self addSubview:_timeLeft];
        
        
        _timeRight = [UILabel new];
        [self addSubview:_timeRight];
        
        
        _playButtton = [UIButton new];
        [self addSubview:_playButtton];
        
        _timeLeft.font = [UIFont systemFontOfSize:14*XA];
        _timeRight.font = [UIFont systemFontOfSize:14*XA];
        
        _timeLeft.textColor = [UIColor grayColor];
        _timeRight.textColor = [UIColor grayColor];
        
        [_playButtton addTarget:self action:@selector(togglePlayButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [_playButtton setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layout];
}


- (void)layout
{
    CGFloat left = 10 * XA;
    CGFloat top = 20 * XA;
    CGFloat width = CGRectGetMaxX(self.frame) - 2*left;
    CGFloat height = 30 * XA;
    
    CGSize size = [_timeLeft.text sizeWithFont:_timeLeft.font maxSize:CGSizeMake(width, 100)];
    width = size.width + 10*XA;
    height = size.height;
    [_timeLeft anchorTopLeftWithLeftPadding:left topPadding:top width:width height:height];
    
    size = [_timeRight.text sizeWithFont:_timeRight.font maxSize:CGSizeMake(width, 100)];
    width = size.width + 10*XA;
    height = size.height;
    [_timeRight anchorTopRightWithRightPadding:left topPadding:top width:width height:height];
    
    
    left = 20*XA;
    height = 30 * XA;
    width = CGRectGetMaxX(self.frame) - ((left + _timeLeft.xMax) *2);
    [_progressView alignToTheRightOf:_timeLeft matchingCenterWithLeftPadding:left width:width height:height];
    
    width = 80*XA;
    height = 80*XA;
    
    [_playButtton alignUnder:_progressView withLeftPadding:20*XA topPadding:40*XA width:width height:height];
    

}

- (void)setData:(NSDictionary *)dict
{
    self.dict = dict;
    
    App(app);
    if ([app.dict[@"mp3"] isEqualToString:_dict[@"mp3"]]) {
        app.player.delegate = self;
        [self scheduleProgressTimer];
        [self updateTogglePlayButton];
    }


    [self setNeedsLayout];
}

- (void)togglePlayButtonClicked
{
    App(app);
    
    if (![app.dict[@"mp3"] isEqualToString:_dict[@"mp3"]]) {
        app.player.delegate = self;
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:_dict[@"mp3"] withExtension:nil];
        [app.player loadItemWithURL:url autoPlay:NO];
    }
    
    app.dict = _dict;
    
    if (app.player.isPlaying) {
        [app.player pause];
    } else {
        [app.player play];
    }
}



+ (CGFloat)height
{
    
    return 150*XA;
}

- (void)dealloc
{
    App(app);
    app.player.delegate = app;
    
    [self unshceduleProgressTimer];
}


#pragma mark - Appearance

- (void)updateTrackProgressView:(NSTimer *)timer
{
    App(app);
    _progressView.progress = app.player.position;
    
    _timeLeft.text = [self getDurationText:app.player.position *app.player.duration];
    _timeRight.text = [self getDurationText:app.player.duration];

}


- (void)updateTogglePlayButton
{
    App(app);
    if (app.player.isPlaying) {
        [_playButtton setImage:[UIImage imageNamed:@"widget_pause_pressed"] forState:UIControlStateNormal];
    } else {
        [_playButtton setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
    }
}

- (void)scheduleProgressTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTrackProgressView:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)unshceduleProgressTimer
{
    [self.timer invalidate];
    self.timer = nil;
}



#pragma mark private method

- (NSString *)getDurationText:(CGFloat)duration
{
    if (duration < 60) {
        return [NSString stringWithFormat:@"00:00:%02.0f", duration];
    }
    else if(duration/60 < 60)
    {
        CGFloat sec = (NSInteger)duration%60;
        CGFloat min = duration/60;
        return [NSString stringWithFormat:@"00:%02.0f:%02.0f", min, sec];
    }
    else if(duration/3600 > 0)
    {
        CGFloat hour = (NSInteger)duration/3600;
        
        duration = (NSInteger)duration%3600;
        
        if(duration/60 < 60)
        {
            CGFloat sec = (NSInteger)duration%60;
            CGFloat min = duration/60;
            return [NSString stringWithFormat:@"%02.0f:%02.0f:%02.0f", hour, min, sec];
        }
        
    }
    
    return @"00:00:00";
}


#pragma mark player

- (void)playerDidChangePlayingStatus:(APAudioPlayer *)player
{
    if (player.isPlaying) {
        [self scheduleProgressTimer];
    } else {
        [self unshceduleProgressTimer];
    }
    [self updateTogglePlayButton];
}



- (void)playerDidFinishPlaying:(APAudioPlayer *)player
{
    [self updateTogglePlayButton];
    [player play];
}


- (void)playerBeginInterruption:(APAudioPlayer *)player
{
    
}


- (void)playerEndInterruption:(APAudioPlayer *)player shouldResume:(BOOL)should
{
    
}

@end
