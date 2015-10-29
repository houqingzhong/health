//
//  TimerHeader.m
//  health
//
//  Created by lizhuzhu on 15/10/25.
//  Copyright © 2015年 lizhuzhu. All rights reserved.
//

#import "TimerHeader.h"
#import "HPublic.h"

@interface TimerHeader()
{
    MZClockView *_clock;
    AGLocationDispatcher  *_locationManager;
    
    UILabel     *_weatherLabel;
    UIImageView *_weatherImageView;
    
    UILabel     *_titleLabel;

}
@end

@implementation TimerHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _titleLabel = [UILabel new];
        _weatherLabel = [UILabel new];
        UIFont *font = [UIFont fontWithName:@"Climacons-Font" size:28*XA];
        _weatherLabel.font = font;
        _weatherLabel.textColor = [UIColor grayBlue];
        
        _weatherImageView = [UIImageView new];
        _weatherImageView.alpha = 0.6;
        
        _locationManager = [[AGLocationDispatcher alloc] init];
        
        [self updateWeather];

        _clock = [[MZClockView alloc] initWithFrame:CGRectMake(0, 0, 150*XA, 150*XA)];
        _clock.themeColor = [UIColor greenHtmlCss];
        
        [_clock playTickingWithTimeInterval:1];

        
        _titleLabel.text = [HPublicMethod getPeriodName];
        
        [self addSubview:_titleLabel];
        [self addSubview:_clock];
        [self addSubview:_weatherLabel];
        [self addSubview:_weatherImageView];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_clock anchorCenterLeftWithLeftPadding:20*XA width:150*XA height:150*XA];
    

    [_weatherImageView anchorTopRightWithRightPadding:0 topPadding:0 width:175*XA height:120*XA];
    
    CGSize size = [_weatherLabel contentSize];
    //[_weatherLabel anchorTopRightWithRightPadding:175*XA topPadding:0 width:size.width height:size.height];
    [_weatherLabel alignUnder:_weatherImageView matchingCenterWithTopPadding:10*XA width:size.width height:size.height];
 
    [_titleLabel anchorInCenterWithWidth:100*XA height:100*XA];
}

- (void)updateWeather
{

    [_locationManager startUpdatingLocationWithBlock:^(CLLocationManager *manager, AGLocation *newLocation, AGLocation *oldLocation) {
        
        
        [[SmileWeatherDownLoader sharedDownloader] getWeatherDataFromLocation:newLocation completion:^(SmileWeatherData * _Nullable data, NSError * _Nullable error) {
            
            if (!error) {
                
                [_locationManager stopUpdatingLocation];
                
                
                
                NSString *conditon = data.currentData.condition;
                if (data.hourlyData.count > 0) {
                    SmileWeatherHourlyData * wdata = data.hourlyData[0];
                    conditon = wdata.condition;
                }

                UIImage *image = [HPublicMethod getWeatherImage:conditon];
                _weatherImageView.image = image;
                
                NSString *text = [NSString stringWithFormat:@"%@%@", data.currentData.dayOfWeek, conditon];
                
                _weatherLabel.text = text;
                
                [self setNeedsLayout];
            }
            else
            {
                NSLog(@"error: %@", error);
            }

        }];
        
    } errorBlock:^(CLLocationManager *manager, NSError *error) {
       
        NSLog(@"error: %@", error);
    }];
}
@end
