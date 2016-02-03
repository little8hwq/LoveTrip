//
//  QLRouteWebService.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-15.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLRoute.h"
#import "QLSoapHelper.h"
#import "QLProduct.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"

@interface QLRouteWebService : NSObject
-(bool)saveRoute:(QLRoute *)route user:(int)userID;
-(NSMutableArray*)queryRouteByUser: (int)userID;
@end
