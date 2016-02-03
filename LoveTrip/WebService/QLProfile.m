//
//  QLProfile.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-6.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLProfile.h"
static QLProfile* currProfile=nil;

@implementation QLProfile

@synthesize userid;
@synthesize username;
@synthesize educatedLevel;
@synthesize salaryLevel;
@synthesize gender;

+(QLProfile*) getCurrProfile
{
    return currProfile;
}

+(void) setCurrProfile:(QLProfile*) profile
{
    currProfile=[[QLProfile alloc] init];
    currProfile.userid=profile.userid;
    currProfile.username=profile.username;
    currProfile.educatedLevel=profile.educatedLevel;
    currProfile.salaryLevel=profile.salaryLevel;
    currProfile.gender=profile.gender;
    currProfile.routes=profile.routes;
}

@end
