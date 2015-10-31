//
//  YYYSSectionView.h
//  health
//
//  Created by lizhuzhu on 15/10/30.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCellPlayer;
@interface YYYSSectionView : UITableViewHeaderFooterView

- (void)setData:(NSDictionary *)dict;

- (BOOL)contained:(NSString *)title;

@end
