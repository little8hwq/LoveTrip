//
//  QLLogWebService.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-15.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLLogWebService : NSObject

-(BOOL)logAction:(int)rate user:(int)userId product:(int)pid;

@end
