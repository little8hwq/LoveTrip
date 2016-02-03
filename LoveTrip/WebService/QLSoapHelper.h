//
//  QLSoapHelper.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-7.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLSoapHelper : NSObject
+(NSMutableURLRequest *)getSoapRequestWithUrl:(NSString*) urlString
                                     soapBody:(NSString*)soapBody
                                   soapAction:(NSString*)soapAction;

@end
