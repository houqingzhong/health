//
//  Player.h
//  health
//
//  Created by lizhuzhu on 15/11/1.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "DOUAudioStreamer.h"

@interface Player : DOUAudioStreamer

- (instancetype)initWithAudioFile:(id <DOUAudioFile>)audioFile target:(id)target;

@end
