//
//  AppDelegate.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "AppDelegate.h"
#import "HPublic.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPMediaItem.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import "Track.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSTimer* timer;
@end

@implementation AppDelegate

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionRouteChangeNotification object:nil];
}

- (DOUAudioStreamer *)createPlayer:(Track *)track target:(id)target
{
    DOUAudioStreamer *player = [[DOUAudioStreamer alloc] initWithAudioFile:track];
    
    [player addObserver:target forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [player addObserver:target forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [player addObserver:target forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
    
//    [player addObserver:self forKeyPath:@"currentTime" options:NSKeyValueObservingOptionNew context:kCurrentTimeKVOKey];
    
    self.target = target;
    
    return player;
}

- (void)destroyPlayer
{

    [self.player removeObserver:_target forKeyPath:@"status"];
    [self.player removeObserver:_target forKeyPath:@"duration"];
    [self.player removeObserver:_target forKeyPath:@"bufferingRatio"];
//    [self.player removeObserver:self forKeyPath:@"timingOffset"];
    
    self.target = nil;
}

- (void)setup
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    [session setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    NSError *activationError = nil;
    [session setActive:YES error:&activationError];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterruptionChangeToState:) name:AVAudioSessionRouteChangeNotification object:nil];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"music.json" withExtension:nil];
    NSError *error = nil;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (nil == error) {
        self.musicData = [jsonString objectFromJSONString];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setup];
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor greenMunsell]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    //4. 该item上边的文字样式
    NSDictionary *fontDic=@{
                            NSForegroundColorAttributeName:[UIColor whiteColor],
                            NSFontAttributeName:[UIFont systemFontOfSize:30*XA],  //粗体
                            };
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UIBarButtonItem *barItem=[UIBarButtonItem appearance];
    [barItem setTitleTextAttributes:fontDic
                           forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:fontDic
                           forState:UIControlStateHighlighted];
    // 5.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    

    [self scheduleProgressTimer];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self unshceduleProgressTimer];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//- (void)playerDidFinishPlaying
//{
//    [[SCLTAudioPlayer sharedPlayer] play];
//}



- (void)handleInterruptionChangeToState:(NSNotification *)notification

{
    
    AudioQueuePropertyID inInterruptionState= (UInt32)[[notification object] longValue];
    

    if (inInterruptionState == kAudioSessionBeginInterruption)
        
    {
        
        [_player pause];
    }
    
    else if (inInterruptionState == kAudioSessionEndInterruption)
        
    {
        
        
        [_player play];
        
    }
    
}


- (void)scheduleProgressTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTrackProgress) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)unshceduleProgressTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateTrackProgress
{
    [self configNowPlayingInfoCenter:self.dict];
    if ([self.player duration] == 0.0) {
        //[_progressView setProgress:0.0f];
    }
    else {
        //[_progressView setProgress:[app.player currentTime] / [app.player duration]];
    }
}

-(void)configNowPlayingInfoCenter:(NSDictionary *)info
{
    
    if (!info) {
        return;
    }
    
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        
        NSMutableDictionary *dict = [NSMutableDictionary new];
        
        if (info[@"track"][@"title"]) {
            dict[MPMediaItemPropertyArtist] = info[@"track"][@"title"];
        }
        if (info[@"track"][@"albumTitle"]) {
            dict[MPMediaItemPropertyAlbumTitle] = info[@"track"][@"albumTitle"];
        }
    
        MPMediaItemArtwork *mArt = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"icon"]];
        dict[MPMediaItemPropertyArtwork] = mArt;

        dict[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(_player.currentTime);
        dict[MPMediaItemPropertyPlaybackDuration] = @(_player.duration-_player.currentTime);
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
        
    }
    
}


@end


//-(void)setAudioSession{
//
//    //AudioSessionInitialize用于控制打断 ，后面会说
//
//    AudioSessionInitialize (
//
//                            NULL,                          // ‘NULL’ to use the default (main) run loop
//
//                            NULL,                          // ‘NULL’ to use the default run loop mode
//
//                            ASAudioSessionInterruptionListener,  // a reference to your interruption callback
//
//                            NULL                       // data to pass to your interruption listener callback
//
//                            );
//
//    //这种方式后台，可以连续播放非网络请求歌曲，遇到网络请求歌曲就废,需要后台申请task
//
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//
//    NSError *setCategoryError = nil;
//
//    BOOL success = [session setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
//
//    if (!success)
//
//    {
//
//        /* handle the error condition */
//
//        return;
//
//    }
//
//    NSError *activationError = nil;
//
//    success = [session setActive:YES error:&activationError];
//
//    if (!success)
//
//    {
//
//        /* handle the error condition */
//
//        return;
//
//    }
//
//}
//
//static void ASAudioSessionInterruptionListener(void *inClientData, UInt32 inInterruptionState)
//
//{
//    App(app);
//    [app handleInterruption:inInterruptionState];
//
//}


