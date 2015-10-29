//
//  AppDelegate.h
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPublic.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, APAudioPlayerDelegate>

@property (strong, nonatomic) UIWindow *window;


/* Player */
@property (nonatomic, strong) APAudioPlayer *player;
@property (nonatomic, strong) NSDictionary  *dict;


@end

