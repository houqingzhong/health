//
//  HPublic.h
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#ifndef HPublic_h
#define HPublic_h
#define XA ScreenSize.width/640
#define ScreenSize [[UIScreen mainScreen] bounds].size
#define XA ScreenSize.width/640
#define WS(s) __weak typeof (self) s = self

#define server_data_cahce  @"server_data_cahce"
#define setting_data_cache @"setting_data_cache"

#define Host       @"http://www.zhiyurencai.cn/music/api/"
#define JingLuoTag @"jingluo"

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;
static void *kCurrentTimeKVOKey = &kCurrentTimeKVOKey;

#import <UIView+Facade.h>
#import <UIColor+MoreColors.h>
#import <UILabel+ContentSize.h>
#import <MZClockView.h>
#import <SmileWeatherDownLoader.h>
#import <AGLocationDispatcher.h>
#import <TTTAttributedLabel.h>
#import <RichStyleLabel.h>
#import <ZCAnimatedLabel.h>
#import <DOUAudioStreamer.h>
#import <YTKKeyValueStore.h>
#import <JSONKit.h>
#import <AESCrypt.h>
#import <MD5Digest/NSString+MD5.h>
#import <NSString+TBEncryption.h>
#import "NSString+Extension.h"
#import "UIColor+Hex.h"
#import "HPublicMethod.h"
#import "Player.h"
#import "WeacherLabel.h"
#import "PeriodHealthCell.h"
#import "HttpClient.h"
#import "TimerHeader.h"
#import "SHFile.h"
#import "SHFile/SHDocumentsFile.h"
#import "WebViewDetailController.h"
#import "IntroViewController.h"
#import "BaseViewController.h"
#import "SCYSViewController.h"
#import "YYYSViewController.h"
#import "DetailViewController.h"


#import "MainViewController.h"
#import "AppDelegate.h"


#define App(s) AppDelegate * s = (AppDelegate *)[[UIApplication sharedApplication] delegate]

#endif /* HPublic_h */
