//
//  QLSearchProductService.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-16.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLSoapHelper.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"

@interface QLSearchProductService : NSObject

-(NSMutableArray *)searchResult:(NSString*)key;
@end
