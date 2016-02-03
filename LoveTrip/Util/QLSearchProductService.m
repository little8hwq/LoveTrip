//
//  QLSearchProductService.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-16.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLSearchProductService.h"
#import "QLProductService.h"

@implementation QLSearchProductService


-(NSMutableArray *)searchResult:(NSString*)key{
    NSString*urlString=@"http://localhost:8080/Service/services/Search";
    NSString*soapBody=[NSString stringWithFormat:@"<searchSpotSight xmlns=\"http://product.com\">"
                       "<key>%@</key>"
                       "</searchSpotSight>",key];
    NSString*soapAction=@"http://product.com/searchSpotSight";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    NSData*result=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self parseSearch:result];

}

-(NSMutableArray*)parseSearch:(NSData*)data
{
    NSString*dataString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    dataString=[dataString stringByReplacingOccurrencesOfString:@"xmlns" withString:@"noNsXml"];//replace xmls
    dataString=[dataString stringByReplacingOccurrencesOfString:@"ns:return" withString:@"return"];//replace ns:
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithXMLString:dataString options:0 error:nil];
    NSLog(@"%@",dataString);
    //利用XPath来定位节点
    NSArray *results = [xmlDoc nodesForXPath:@"//return" error:nil];
    QLProductService* ws=[[QLProductService alloc]init];
    NSMutableArray* updateProducts=[[NSMutableArray alloc]init];
    for (DDXMLElement *result in results)
    {
        NSString* temp=[result stringValue];
        QLProduct* product=[ws queryProduct:[temp intValue]];
        [updateProducts addObject:product];
            
    }
    return updateProducts;
}
@end
