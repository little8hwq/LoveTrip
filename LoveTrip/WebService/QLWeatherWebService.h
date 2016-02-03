//
//  QLWeatherWebService.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-11.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLWeather.h"
#import "QLSoapHelper.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"

@interface QLWeatherWebService : NSObject
-(QLWeather*)queryWeather:(NSString*)cityName;
@end
