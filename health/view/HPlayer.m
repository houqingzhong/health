//
//  HPlayer.m
//  health
//
//  Created by lizhuzhu on 15/10/29.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "HPlayer.h"
#import "HPublic.h"
#import "Track.h"
#import "TDSession.h"
#import <UIImage+AFNetworking.h>

@interface HPlayer()
{
}
/* Timer */
@property (nonatomic, strong) NSTimer *timer;


@property (strong, nonatomic) TDSession *session;

@end

@implementation HPlayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
       
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    _progressView = [UILabel new];
    [self addSubview:_progressView];
    
    _statusLabel = [UILabel new];
    
    [self addSubview:_statusLabel];
    
    
    _playButtton = [UIButton new];
    [self addSubview:_playButtton];
    
    _statusLabel.font = [UIFont systemFontOfSize:28*XA];
    _statusLabel.textColor = [UIColor rebeccaPurple];
    
    _progressView.backgroundColor = [UIColor greenRyb];
    [_playButtton addTarget:self action:@selector(togglePlayButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_playButtton setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
    
    self.session = [[TDSession alloc] init];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layout];
}


- (void)layout
{
    CGFloat left = 10 * XA;
    CGFloat width = CGRectGetMaxX(self.frame) - 2*left;
    CGFloat height = 30 * XA;
    
    App(app);
    if ([app.player duration] == 0.0) {
        width = 0;
    }
    else {
        width = self.width* [app.player currentTime] / [app.player duration];
    }
    [_progressView anchorTopLeftWithLeftPadding:0 topPadding:0 width:width height:1*XA];
    
    width = 80*XA;
    height = 80*XA;
    
    [_playButtton alignUnder:_progressView withLeftPadding:20*XA topPadding:40*XA width:width height:height];

    width = self.width - _playButtton.xMax - 30*XA - 20*XA;
    [_statusLabel alignToTheRightOf:_playButtton matchingCenterWithLeftPadding:30*XA width:width height:60*XA];
    
}

- (void)setData:(NSDictionary *)dict
{
    self.dict = dict;
    _statusLabel.text = _dict[@"track"][@"title"];
    App(app);
    NSInteger playingTrackId = [app.dict[@"track"][@"trackId"] integerValue];
    NSInteger trackId = [_dict[@"track"][@"trackId"] integerValue];
    if (trackId == playingTrackId) {
        [self scheduleProgressTimer];
        [self updateTogglePlayButton];
    }

    [self setNeedsLayout];
}

- (void)togglePlayButtonClicked
{
    App(app);
    NSInteger playingTrackId = [app.dict[@"track"][@"trackId"] integerValue];
    NSInteger trackId = [_dict[@"track"][@"trackId"] integerValue];
    if (trackId != playingTrackId) {
        NSString *urlString = _dict[@"track"][@"playPathAacv224"];
        if (urlString) {
            //stop
            [app.player stop];
            
            
            //play
            Track *track = [[Track alloc] init];
            [track setTitle:_dict[@"track"][@"title"]];
            [track setAudioFileURL:[NSURL URLWithString:urlString]];
            
            if (app.player) {
                [app destroyPlayer];
            }
            app.player = [app createPlayer:track target:self];
            
            [app configNowPlayingInfoCenter:_dict];
            
            [app.player play];
            
            [_playButtton setImage:[UIImage imageNamed:@"widget_pause_pressed"] forState:UIControlStateNormal];

            app.dict = _dict;

            [self scheduleProgressTimer];
            
        }

    }
    else
    {
        if (DOUAudioStreamerPlaying == app.player.status) {
            [app.player pause];
            [_playButtton setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
        }
        else
        {
            [app.player play];
            [_playButtton setImage:[UIImage imageNamed:@"widget_pause_pressed"] forState:UIControlStateNormal];
        }
    }
}

+ (CGFloat)height
{
    
    return 150*XA;
}

- (void)dealloc
{
    [self unshceduleProgressTimer];
}


#pragma mark - Appearance

- (void)updateTrackProgressView:(NSTimer *)timer
{

//    App(app);
//    CGRect rc = _progressView.frame;
//    if ([app.player duration] == 0.0) {
//        //[_progressView setProgress:0.0f];
//        rc.size.width = 0;
//
//    }
//    else {
//        //[_progressView setProgress:[app.player currentTime] / [app.player duration]];
//        rc.size.width = self.width* [app.player currentTime] / [app.player duration];
//    }
//    _progressView.frame = rc;
    [self setNeedsLayout];
}

- (void)scheduleProgressTimer
{
    [self.timer invalidate];
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


- (void)updateTogglePlayButton
{
    App(app);
    if (DOUAudioStreamerPlaying == app.player.status){
        [_playButtton setImage:[UIImage imageNamed:@"widget_pause_pressed"] forState:UIControlStateNormal];
    } else {
        [_playButtton setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
    }
}

- (void)updateStatus
{
    App(app);
    NSLog(@"player status %lu", (unsigned long)app.player.status);
    
    switch (app.player.status) {
        case DOUAudioStreamerPlaying:
            [_statusLabel setText:_dict[@"track"][@"title"]];
            [_playButtton setImage:[UIImage imageNamed:@"widget_pause_pressed"] forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerPaused:
            [_statusLabel setText:_dict[@"track"][@"title"]];
            [_playButtton setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerIdle:
            [_statusLabel setText:_dict[@"track"][@"title"]];
            [_playButtton setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerFinished:
            [_statusLabel setText:@"finished"];
            [_statusLabel setText:_dict[@"track"][@"title"]];
            [_playButtton setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
            [app.player play];
            break;
            
        case DOUAudioStreamerBuffering:
            [_statusLabel setText:@"buffering"];
            [_statusLabel setText:[NSString stringWithFormat:@"加载中..."]];
            [_playButtton setImage:[UIImage imageNamed:@"widget_pause_pressed"] forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerError:
            [_statusLabel setText:@"error"];
            [_statusLabel setText:_dict[@"track"][@"title"]];
            [_playButtton setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
            break;
    }
}

- (void)updateBufferingStatus
{
    App(app);
//    [_statusLabel setText:[NSString stringWithFormat:@"Received %.2f/%.2f MB (%.2f %%), Speed %.2f MB/s", (double)[app.player receivedLength] / 1024 / 1024, (double)[app.player expectedLength] / 1024 / 1024, [app.player bufferingRatio] * 100.0, (double)[app.player downloadSpeed] / 1024 / 1024]];
    
    if ([app.player bufferingRatio] >= 1.0) {
        NSLog(@"sha256: %@", [app.player sha256]);
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        [self performSelector:@selector(updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if ([keyPath isEqualToString:@"duration"]) {
        [self performSelector:@selector(updateTrackProgressView:)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if ([keyPath isEqualToString:@"bufferingRatio"]) {
        [self performSelector:@selector(updateBufferingStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
