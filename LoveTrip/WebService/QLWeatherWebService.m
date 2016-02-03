//
//  QLWeatherWebService.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-11.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLWeatherWebService.h"

@interface QLWeatherWebService()

-(QLWeather*)parseWeather:(NSData*)data;
-(void)parseData:(NSString*)data weather:(QLWeather*)weather;
@end
@implementation QLWeatherWebService

-(QLWeather*)queryWeather:(NSString*)cityName
{
    NSString*urlString=@"http://www.webxml.com.cn/WebServices/WeatherWebService.asmx";
    NSString*soapBody=[NSString stringWithFormat:@"<getWeatherbyCityName xmlns=\"http://WebXml.com.cn/\">"
                       "<theCityName>%@</theCityName>"
                       "</getWeatherbyCityName>",cityName];
    NSString*soapAction=@"http://WebXml.com.cn/getWeatherbyCityName";
    NSMutableURLRequest* request=[QLSoapHelper getSoapRequestWithUrl:urlString soapBody:soapBody soapAction:soapAction];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [self parseWeather:returnData];
}

-(QLWeather*)parseWeather:(NSData*)data
{
    NSString*dataString=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    dataString=[dataString stringByReplacingOccurrencesOfString:@"xmlns" withString:@"noNsXml"];//replace xmls
    
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithXMLString:dataString options:0 error:nil];
    
    //利用XPath来定位节点
    NSArray *results = [xmlDoc nodesForXPath:@"//string" error:nil];
    NSMutableArray *strings=[[NSMutableArray alloc]init];
    QLWeather*weather =[[QLWeather alloc]init];
    
    for(DDXMLElement* result in results)
    {
        [strings addObject:[result stringValue]];
    }
    if ([strings count]==0||[[strings objectAtIndex:0] isEqualToString:@"查询结果为空！"]||[[strings objectAtIndex:11] isEqualToString:@"暂无预报"])
    {
        weather.currTemp=@"未知";
        weather.weather=@"-";
        weather.tempRange=@"-";
        weather.wind=@"-";
        weather.humidity=@"-";
        weather.ultraviolet=@"-";
        weather.imgUrl=@"nothing";
        weather.lastUpdateDate=@"";
    }
    else
    {
        NSArray*temp=[[strings objectAtIndex:6] componentsSeparatedByString:@" "];
        weather.weather=[temp objectAtIndex:1];
        weather.tempRange=[strings objectAtIndex:5];
        int imgIndex=[[[[strings objectAtIndex:8] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
        NSLog(@"index=%d",imgIndex);
        switch (imgIndex) {
            case 0:
                weather.imgUrl=@"sun-hd@2x";
                break;
            case 1:
                weather.imgUrl=@"cloud-hd@2x";
                break;
            case 2:
                weather.imgUrl=@"yin-hd@2x";
                break;
            case 4:case 5:
                weather.imgUrl=@"thunder-hd@2x";
                break;
            default:
                weather.imgUrl=@"rain-hd@2x";
                break;
        }
        weather.lastUpdateDate=[NSString stringWithFormat:@"更新:%@",[strings objectAtIndex:4]];
        [self parseData:[strings objectAtIndex:10] weather:weather];
    }
    return weather;
}

-(void)parseData:(NSString*)data weather:(QLWeather*)weather
{
    NSString*temp=[data substringFromIndex:7];
    NSArray*tempArray=[temp componentsSeparatedByString:@"；"];
    weather.currTemp=[[tempArray objectAtIndex:0] substringFromIndex:3];
    weather.wind=[[tempArray objectAtIndex:1] substringFromIndex:6];
    weather.humidity=[[tempArray objectAtIndex:2] substringFromIndex:3];
    weather.ultraviolet=[tempArray objectAtIndex:4];
}
@end
