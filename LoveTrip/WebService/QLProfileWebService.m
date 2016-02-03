//
//  QLProfileWebService.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-7.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLProfileWebService.h"

@interface QLProfileWebService()
-(QLProfile*) parseProfileWithData:(NSData*)data nodeName:(NSString*) nodeName;
-(int) parseRegister:(NSData*)data;
@end

@implementation QLProfileWebService

-(QLProfile*) queryProfile:(NSString*)username
{
    NSString*urlString=@"http://www.chenniao.com:8085/admin/webservice/WebServiceProfile.asmx";
    NSString*soapBody=[NSString stringWithFormat:@"<queryProfile xmlns=\"http://com.webservice.profile/\">"
                       "<username>%@</username>"
                       "</queryProfile>",username];
    NSString*soapAction=@"http://com.webservice.profile/queryProfile";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self parseProfileWithData:returnData nodeName:@"//queryProfileResult"];
}

-(QLProfile*) loginWithName:(NSString*)username password:(NSString*)password
{
    NSString*urlString=@"http://www.chenniao.com:8085/admin/webservice/WebServiceProfile.asmx";
    NSString*soapBody=[NSString stringWithFormat:@"<login xmlns=\"http://com.webservice.profile/\">"
                       "<username>%@</username>"
                        "<password>%@</password>"
                       "</login>",username,password];
    NSString*soapAction=@"http://com.webservice.profile/login";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self parseProfileWithData:returnData nodeName:@"//loginResult"];
}

-(int) registerWithName:(NSString*)username password:(NSString*)password gender:(NSString*)gender nick:(NSString*)nick
{
    NSString*urlString=@"http://www.chenniao.com:8085/admin/webservice/WebServiceProfile.asmx";
    NSString*soapBody=[NSString stringWithFormat:@"<registerUserByString xmlns=\"http://com.webservice.profile/\">"
                       "<username>%@</username>"
                       "<gender>%@</gender>"
                       "<password>%@</password>"
                       "<nick>%@</nick>"
                       "</registerUserByString>",username,gender,password,nick];
    NSString*soapAction=@"http://com.webservice.profile/registerUserByString";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self parseRegister:returnData];
}

-(QLProfile*) parseProfileWithData:(NSData*)data nodeName:(NSString*) nodeName
{
    NSString*dataString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    dataString=[dataString stringByReplacingOccurrencesOfString:@"xmlns" withString:@"noNsXml"];//replace xmls
    
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithXMLString:dataString options:0 error:nil];

    //利用XPath来定位节点
    NSArray *users = [xmlDoc nodesForXPath:nodeName error:nil];
    NSLog(@"result=%@",dataString);
    for (DDXMLElement *user in users)
    {
        QLProfile* profile=[[QLProfile alloc] init];
        DDXMLElement *idEle = [user elementForName:@"id"];
        DDXMLElement *nameEle = [user elementForName:@"username"];
        DDXMLElement *eduEle = [user elementForName:@"educatedLevel"];
        DDXMLElement *salEle=[user elementForName:@"salaryLevel"];
        DDXMLElement *genderEle=[user elementForName:@"gender"];
        profile.userid=[[idEle stringValue] intValue];
        profile.username=[nameEle stringValue];
        profile.educatedLevel=[eduEle stringValue];
        profile.salaryLevel=[salEle stringValue];
//        NSLog(@"gender=%@",[genderEle stringValue]);
        profile.gender=[genderEle stringValue];
        return profile;
       
    }
    return nil;
    
}

-(int) parseRegister:(NSData*)data{
    NSString*dataString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    dataString=[dataString stringByReplacingOccurrencesOfString:@"xmlns" withString:@"noNsXml"];//replace xmls
    
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithXMLString:dataString options:0 error:nil];
    
    //利用XPath来定位节点
    NSArray *users = [xmlDoc nodesForXPath:@"//registerUserByStringResponse" error:nil];
    int userid=0;
    for (DDXMLElement *user in users)
    {
        DDXMLElement *idEle = [user elementForName:@"registerUserByStringResult"];
        userid=[[idEle stringValue] intValue];
    }
    return userid;
}
@end
