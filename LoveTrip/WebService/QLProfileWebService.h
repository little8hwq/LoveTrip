//
//  QLProfileWebService.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-7.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLProfile.h"
#import "QLSoapHelper.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"

@interface QLProfileWebService : NSObject
-(QLProfile*) queryProfile:(NSString*)username;
-(QLProfile*) loginWithName:(NSString*)username
                   password:(NSString*)password;
-(int) registerWithName:(NSString*)username
               password:(NSString*)password
                 gender:(NSString*)gender
                   nick:(NSString*)nick;
@end
