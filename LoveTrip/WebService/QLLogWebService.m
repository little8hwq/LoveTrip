//
//  QLLogWebService.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-15.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLLogWebService.h"
#import "QLSoapHelper.h"

@implementation QLLogWebService

-(BOOL)logAction:(int)rate user:(int)userId product:(int)pid
{
    NSString*urlString=@"http://localhost:8080/Service/services/Recommend";
    NSString*soapBody=[NSString stringWithFormat:@"<log xmlns=\"http://recommend.com\">"
                       "<User>%d</User>"
                       "<pid>%d</pid>"
                       "<rate>%d</rate>"
                       "</log>",userId,pid,rate];
    NSString*soapAction=@"http://recommend.com/log";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return TRUE;
}

@end
