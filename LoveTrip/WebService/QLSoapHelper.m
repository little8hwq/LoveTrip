//
//  QLSoapHelper.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-7.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLSoapHelper.h"

@implementation QLSoapHelper
+(NSMutableURLRequest *)getSoapRequestWithUrl:(NSString*) urlString
                                     soapBody:(NSString*)soapBody
                                   soapAction:(NSString*)soapAction
{
    NSString *soapString=[[NSString alloc] initWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>"
                          "%@"
                          "</soap:Body>"
                          "</soap:Envelope>",soapBody];
     NSURL *url=[[NSURL alloc] initWithString:urlString];
     NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];

    //设置请求头部
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:soapAction forHTTPHeaderField:@"SOAPAction"];
    [request addValue:[NSString stringWithFormat:@"%d",[soapString length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    
    //设置请求Body
    [request setHTTPBody:[soapString dataUsingEncoding:NSUTF8StringEncoding]];

    return request;
    
}

@end
