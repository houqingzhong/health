//
//  AppDelegate.h
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPublic.h"

@class Track;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


/* Player */
@property (nonatomic, strong) DOUAudioStreamer *player;

@property (nonatomic, strong) NSDictionary  *dict;

@property (nonatomic, strong) NSDictionary *musicData;
@property (nonatomic, strong) id target;

- (DOUAudioStreamer *)createPlayer:(Track *)track target:(id)target;
- (void)destroyPlayer;

-(void)configNowPlayingInfoCenter:(NSDictionary *)info;
@end

