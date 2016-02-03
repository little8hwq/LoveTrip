//
//  QLWeatherViewController.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-11.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLWeather.h"
#import "QLWeatherWebService.h"

@interface QLWeatherViewController : UIViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *currTempLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *ultraLabel;

@end
