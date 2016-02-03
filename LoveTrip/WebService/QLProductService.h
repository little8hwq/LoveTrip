//
//  QLProductService.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-10.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLSoapHelper.h"
#import "QLProduct.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"

@interface QLProductService : NSObject
-(QLProduct*) queryProduct:(int)pid;
-(NSMutableArray*) queryAllWithType:(int)type start:(int)start size:(int)size;
@end
