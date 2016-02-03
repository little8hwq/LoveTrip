//
//  QLSearchProducts.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-12.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLProductType.h"
#import "QLProductService.h"

@interface QLSearchProducts : NSObject

@property NSInteger startIndex;
@property bool searchName;

-(NSMutableArray *)searchHotelProducts:(NSString *)key searchType:(QLProductType *)QLType;
-(NSMutableArray *)searchTrafficProducts:(NSString *)key searchType:(QLProductType *)QLType;
-(NSMutableArray *)searchSpotSightProducts:(NSString *)key searchType:(QLProductType *)QLType;
@end
