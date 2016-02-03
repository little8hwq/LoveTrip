//
//  QLRouteWebService.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-15.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLRouteWebService.h"
#import "QLProductService.h"

@interface QLRouteWebService()
-(NSMutableArray*)parseRoutes:(NSData*) data;
@end

@implementation QLRouteWebService

-(bool)saveRoute:(QLRoute *)route user:(int)userID
{
    NSMutableString* result=[[NSMutableString alloc]init];
    [result appendString:route.name];
    for (QLProduct* product in route.products) {
        [result appendString:[NSString stringWithFormat:@",%d",product.pid]];
    }
    NSString*urlString=@"http://localhost:8080/Service/services/Route";
    NSString*soapBody=[NSString stringWithFormat:@"<saveRoute xmlns=\"http://route.com\">"
                       "<user>%d</user>"
                       "<route>%@</route>"
                       "</saveRoute>",userID,result];
    NSString*soapAction=@"http://route.com/saveRoute";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return YES;
}

-(NSMutableArray*)queryRouteByUser: (int)userID
{
    NSString*urlString=@"http://localhost:8080/Service/services/Route";
    NSString*soapBody=[NSString stringWithFormat:@"<queryAll xmlns=\"http://route.com\">"
                       "<user>%d</user>"
                       "</queryAll>",userID];
    NSString*soapAction=@"http://route.com/queryAll";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    NSData*result=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self parseRoutes:result];
}

-(NSMutableArray*)parseRoutes:(NSData*) data
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
