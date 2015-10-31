//
//  YYTrackCell.h
//  health
//
//  Created by lizhuzhu on 15/10/31.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "HBaseCell.h"

@interface YYTrackCell : HBaseCell

- (void)play:(NSDictionary *)dict;

- (void)updateProgress;

- (void)updateAnimation:(BOOL)show;

@end
