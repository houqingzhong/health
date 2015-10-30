//
//  BaseViewController.m
//  health
//
//  Created by lizhuzhu on 15/10/28.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "BaseViewController.h"
#import "HPublic.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIDevice *device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ( [device respondsToSelector:@selector(isMultitaskingSupported)] )
    {
        backgroundSupported = device.multitaskingSupported;
    }
    
    if ( backgroundSupported == YES )
    {
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        //注意这里，告诉系统已经准备好了
        [self becomeFirstResponder];
    }
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)introView
{
    
}



#pragma remote event

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    
    App(app);
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
                if (DOUAudioStreamerPlaying == app.player.status) {
                    [app.player pause];
                }
                else
                {
                    [app.player play];
                }
                break;
            case UIEventSubtypeRemoteControlPlay:
                [app.player play];
                break;
            case UIEventSubtypeRemoteControlPause:
                [app.player pause];
                break;
            case UIEventSubtypeRemoteControlStop:
            {
                //todo stop event
                break;
            }
                
            case UIEventSubtypeRemoteControlNextTrack:
            {
                //todo play next song
                
                break;
            }
                
            case UIEventSubtypeRemoteControlPreviousTrack:
            {
                //todo play previous song
                break;
            }
            default:
                break;
        }
    }
}
@end
