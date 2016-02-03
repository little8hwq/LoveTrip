//
//  QLProduct.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-10.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLProduct : NSObject
@property int pid;
@property int classId;
@property NSString* name;
@property NSString* description;
@property float price;
@property int productType;
@property NSDate* lastUpdateDate;
@property NSString* imgUrl;
@property NSString* source;

@end
