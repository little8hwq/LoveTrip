//
//  QLRoute.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-11.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLRoute.h"


@implementation QLRoute

@synthesize name;
@synthesize routeId;
@synthesize rate;
@synthesize products;

-(void)addProduct:(QLProduct*)product
{
    [self.products addObject:product];
}

-(id)init
{
    self=[super init];
    self.products=[[NSMutableArray alloc]init];
    return self;
}

-(QLProduct*) getProduct:(int)index
{
    return self.products[index];
}

@end
