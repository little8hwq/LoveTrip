//
//  QLRecommendWebService.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-15.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLRecommendWebService.h"
#import "QLRoute.h"
#import "QLSoapHelper.h"
#import "QLProductService.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"

@interface QLRecommendWebService()
-(NSMutableArray*)parseRecommend:(NSData*)data;
@end

@implementation QLRecommendWebService

-(NSMutableArray*) recommendByUser:(int)userId
{
    NSString*urlString=@"http://localhost:8080/Service/services/Recommend";
    NSString*soapBody=[NSString stringWithFormat:@"<recommend xmlns=\"http://recommend.com\">"
                       "<user>%d</user>"
                       "</recommend>",userId];
    NSString*soapAction=@"http://recommend.com/recommend";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    NSData*result=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self parseRecommend:result];
}

-(NSMutableArray*)parseRecommend:(NSData*)data
{
    NSString*dataString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    dataString=[dataString stringByReplacingOccurrencesOfString:@"xmlns" withString:@"noNsXml"];//replace xmls
    dataString=[dataString stringByReplacingOccurrencesOfString:@"ns:return" withString:@"return"];//replace ns:
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithXMLString:dataString options:0 error:nil];
    
    //利用XPath来定位节点
    NSArray *results = [xmlDoc nodesForXPath:@"//return" error:nil];
    QLProductService* ws=[[QLProductService alloc]init];
    NSMutableArray* routes=[[NSMutableArray alloc]initWithCapacity:5];
    for (DDXMLElement *result in results)
    {
        NSString* temp=[result stringValue];
        NSArray* strings=[temp componentsSeparatedByString:@","];
        QLRoute* route=[[QLRoute alloc]init];
        route.name=strings[0];
        for (int i=1; i<[strings count]; i++)
        {
            QLProduct* product=[ws queryProduct:[strings[i] intValue]];
            [route addProduct:product];
        }
        [routes addObject:route];
    }
    return routes;
}
@end
