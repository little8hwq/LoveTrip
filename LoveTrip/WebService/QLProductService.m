//
//  QLProductService.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-10.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLProductService.h"

@interface QLProductService()
-(NSMutableArray*)parseAllProduct:(NSData*)data;
-(QLProduct*)parseProduct:(NSData*)data;
@end
@implementation QLProductService
-(QLProduct*) queryProduct:(int)pid
{
    NSString*urlString=@"http://www.chenniao.com:8085/admin/webservice/WebServiceProduct.asmx";
    NSString*soapBody=[NSString stringWithFormat:@"<queryProduct xmlns=\"http://com.webservice.product/\">"
                       "<productId>%d</productId>"
                       "</queryProduct>",pid];
    NSString*soapAction=@"http://com.webservice.product/queryProduct";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self parseProduct:returnData];
}

-(NSArray*) queryAllWithType:(int)type start:(int)start size:(int)size
{
    NSString*urlString=@"http://www.chenniao.com:8085/admin/webservice/WebServiceProduct.asmx";
    NSString*soapBody=[NSString stringWithFormat:@"<queryAll xmlns=\"http://com.webservice.product/\">"
                       "<type>%d</type>"
                       "<start>%d</start>"
                       "<size>%d</size>"
                       "</queryAll>",type,start,size];
    NSString*soapAction=@"http://com.webservice.product/queryAll";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self parseAllProduct:returnData];
}

-(NSMutableArray*)parseAllProduct:(NSData*)data
{
    NSString*dataString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    dataString=[dataString stringByReplacingOccurrencesOfString:@"xmlns" withString:@"noNsXml"];//replace xmls
    
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithXMLString:dataString options:0 error:nil];
    
    //利用XPath来定位节点
    NSArray *results = [xmlDoc nodesForXPath:@"//EntityProductResult" error:nil];
    NSMutableArray *products=[NSMutableArray arrayWithCapacity:[results count]];
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for (DDXMLElement *result in results)
    {
        QLProduct*product=[[QLProduct alloc]init];
        DDXMLElement *pidEle = [result elementForName:@"id"];
        DDXMLElement *cidEle = [result elementForName:@"classId"];
        DDXMLElement *nameEle=[result elementForName:@"name"];
        DDXMLElement *desEle=[result elementForName:@"description"];
        DDXMLElement *souEle=[result elementForName:@"source"];
        DDXMLElement *priceEle=[result elementForName:@"price"];
        DDXMLElement *typeEle=[result elementForName:@"productType"];
        DDXMLElement *dateEle=[result elementForName:@"lastUpdateDate"];
        DDXMLElement *imgEle=[result elementForName:@"imgUrl"];
        product.pid=[[pidEle stringValue]intValue];
        product.classId=[[cidEle stringValue]intValue];
        product.name=[nameEle stringValue];
        product.description=[desEle stringValue];
        product.source=[souEle stringValue];
        product.price=[[priceEle stringValue] floatValue];
        product.productType=[[typeEle stringValue]intValue];
        product.lastUpdateDate=[dateFormatter dateFromString:[dateEle stringValue]];
        product.imgUrl=[imgEle stringValue];
        [products addObject:product];
    }
    return products;
}

-(QLProduct*)parseProduct:(NSData*)data
{
    NSString*dataString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    dataString=[dataString stringByReplacingOccurrencesOfString:@"xmlns" withString:@"noNsXml"];//replace xmls
    
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithXMLString:dataString options:0 error:nil];
    
    //利用XPath来定位节点
    NSArray *results = [xmlDoc nodesForXPath:@"//queryProductResult" error:nil];
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for (DDXMLElement *result in results)
    {
        QLProduct*product=[[QLProduct alloc]init];
        DDXMLElement *pidEle = [result elementForName:@"id"];
        DDXMLElement *cidEle = [result elementForName:@"classId"];
        DDXMLElement *nameEle=[result elementForName:@"name"];
        DDXMLElement *desEle=[result elementForName:@"description"];
        DDXMLElement *souEle=[result elementForName:@"source"];
        DDXMLElement *priceEle=[result elementForName:@"price"];
        DDXMLElement *typeEle=[result elementForName:@"productType"];
        DDXMLElement *dateEle=[result elementForName:@"lastUpdateDate"];
        DDXMLElement *imgEle=[result elementForName:@"imgUrl"];
        product.pid=[[pidEle stringValue]intValue];
        product.classId=[[cidEle stringValue]intValue];
        product.name=[nameEle stringValue];
        product.description=[desEle stringValue];
        product.source=[souEle stringValue];
        product.price=[[priceEle stringValue] floatValue];
        product.productType=[[typeEle stringValue]intValue];
        product.lastUpdateDate=[dateFormatter dateFromString:[dateEle stringValue]];
        product.imgUrl=[imgEle stringValue];
        return product;
    }
    return nil;
}

@end
