//
//  QLProductType.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-10.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int ROUTE=1;
static const int TRAFFIC=2;
static const int HOTEL=3;
static const int SIGHTSPOT=4;

@interface QLProductType : NSObject
@property int type;
@property NSString* name;
@property NSString* subtitle;

@end
