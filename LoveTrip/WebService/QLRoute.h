//
//  QLRoute.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-11.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLProduct.h"

@interface QLRoute : NSObject

@property NSMutableArray* products;
@property NSString* name;
@property int routeId;
@property int rate;

-(void)addProduct:(QLProduct*)product;
-(id)init;
-(QLProduct*) getProduct:(int)index;

@end
