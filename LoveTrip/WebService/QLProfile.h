//
//  QLProfile.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-6.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLProfile : NSObject
@property int userid;
@property NSString* username;
@property NSString* educatedLevel;
@property NSString* salaryLevel;
@property NSString* gender;
@property NSArray* routes;

+(QLProfile*) getCurrProfile;
+(void) setCurrProfile:(QLProfile*) profile;

@end
