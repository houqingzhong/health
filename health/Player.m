//
//  Player.m
//  health
//
//  Created by lizhuzhu on 15/11/1.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "Player.h"
#import "HPublic.h"

@interface Player()
@property (nonatomic, strong) DOUAudioStreamer *player;

@property (nonatomic, weak)   id  target;
@end

@implementation Player

- (void)dealloc
{
    
    [self destroyPlayer];
    self.target = nil;
    
}

- (instancetype)initWithAudioFile:(id <DOUAudioFile>)audioFile target:(id)target
{
    self = [super init];
    if (self) {
        _player = [self createPlayer:audioFile target:target];
    }
    
    return self;
}

- (DOUAudioStreamer *)createPlayer:(id <DOUAudioFile>)track target:(id)target
{
    DOUAudioStreamer *player = [[DOUAudioStreamer alloc] initWithAudioFile:track];
    
    [player addObserver:target forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [player addObserver:target forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [player addObserver:target forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
    
    self.target = target;

    return player;
}

- (void)destroyPlayer
{
    
    [self.player removeObserver:_target forKeyPath:@"status"];
    [self.player removeObserver:_target forKeyPath:@"duration"];
    [self.player removeObserver:_target forKeyPath:@"bufferingRatio"];
    
    self.target = nil;
}


@end
