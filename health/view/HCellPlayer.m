//
//  HCellPlayer.m
//  health
//
//  Created by lizhuzhu on 15/10/31.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "HCellPlayer.h"
#import "HPublic.h"
#import "Track.h"

@implementation HCellPlayer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setup
{
    [super setup];
        
}

- (void)layout
{
    [super layout];
    CGFloat width = 0;
    CGFloat height = 0;
    App(app);
    if ([app.player duration] == 0.0) {
        width = 0;
    }
    else {
        width = self.width* [app.player currentTime] / [app.player duration];
    }
    
    [self.progressView anchorBottomLeftWithLeftPadding:0 bottomPadding:0 width:width height:1*XA];

    width = 60*XA;
    height = 60*XA;
    
    [self.playButtton anchorCenterLeftWithLeftPadding:20*XA width:width height:height];
    
    width = self.width - self.playButtton.xMax - 30*XA - 20*XA;
    [self.statusLabel alignToTheRightOf:self.playButtton matchingCenterWithLeftPadding:30*XA width:width height:60*XA];

}

- (void)setData:(NSDictionary *)dict
{
}

- (void)play:(NSDictionary *)dict
{
    self.dict = dict;
    
    App(app);
    NSInteger playingTrackId = [app.dict[@"track"][@"trackId"] integerValue];
    NSInteger trackId = [dict[@"track"][@"trackId"] integerValue];
    if (trackId != playingTrackId) {
        NSString *urlString = dict[@"track"][@"playPathAacv224"];
        if (urlString) {
            //stop
            [app.player stop];
            
            //play
            Track *track = [[Track alloc] init];
            [track setTitle:dict[@"track"][@"title"]];
            [track setAudioFileURL:[NSURL URLWithString:urlString]];
            
            if (app.player) {
                [app destroyPlayer];
            }
            app.player = [app createPlayer:track target:self];
            
            [app configNowPlayingInfoCenter:dict];
            
            [app.player play];
            
            [self.playButtton setImage:[UIImage imageNamed:@"widget_pause_pressed"] forState:UIControlStateNormal];
            
            app.dict = dict;
            
            [self scheduleProgressTimer];
            
        }
        
    }
    else
    {
        if (DOUAudioStreamerPlaying == app.player.status) {
            [app.player pause];
            [self.playButtton setImage:[UIImage imageNamed:@"widget_play_pressed"] forState:UIControlStateNormal];
        }
        else
        {
            [app.player play];
            [self.playButtton setImage:[UIImage imageNamed:@"widget_pause_pressed"] forState:UIControlStateNormal];
        }
    }
}

- (void)updateProgress
{
    CGFloat width = 0;
    App(app);
    if ([app.player duration] == 0.0) {
        width = 0;
    }
    else {
        width = self.width* [app.player currentTime] / [app.player duration];
    }
    
    [self.progressView anchorBottomLeftWithLeftPadding:0 bottomPadding:0 width:width height:1*XA];

}

- (void)scheduleProgressTimer
{
    
}

- (void)unshceduleProgressTimer
{
    
}

@end
