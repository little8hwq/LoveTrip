//
//  QLSearchProducts.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-12.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLSearchProducts.h"
#import "QLSearchProductService.h"

@implementation QLSearchProducts

@synthesize startIndex;

@synthesize searchName;

//查找酒店
-(NSMutableArray *)searchHotelProducts:(NSString *)key searchType:(QLProductType *)QLType{
    
    QLProductService*webs =[[QLProductService alloc] init];
    NSMutableArray *allproductsForName = [[NSMutableArray alloc]init];
    NSMutableArray *updateProducts = [[NSMutableArray alloc]init];
    
    if (searchName) {
        allproductsForName=[webs queryAllWithType:QLType.type start:0 size:120];
        //查找名字相关
        for (int i = 0; i < [allproductsForName count]; i++) {
            QLProduct *product = [allproductsForName objectAtIndex:i];
            NSString *name = product.name;
            NSRange range = [name rangeOfString:key];
            if(range.length!=0){
                [updateProducts addObject:product];
                
            }
        }
        searchName = NO;
    }
    
    //查找内容相关
    if(self.startIndex <= 80){
        for (int i = self.startIndex; i < self.startIndex+40 && i < [allproductsForName count]; i++) {
            QLProduct *product = [allproductsForName objectAtIndex:i];
            NSString *description = product.description;
            NSRange range = [description rangeOfString:key];
            if(range.length!=0){
            
                if (![updateProducts containsObject:product]){
                    [updateProducts addObject:product];
                    NSLog(@"2%@",product.name);
                }
            
            }
        }
    }
    NSLog(@"%d",startIndex);
    self.startIndex+=40;
    
    
    return updateProducts;
}

//查找交通产品
-(NSMutableArray *)searchTrafficProducts:(NSString *)key searchType:(QLProductType *)QLType{
    QLProductService*ws =[[QLProductService alloc] init];
    NSMutableArray *allproducts = [[NSMutableArray alloc]init];
    allproducts=[ws queryAllWithType:QLType.type start:self.startIndex size:40];
    self.startIndex += 40;
    NSMutableArray *updateProducts = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [allproducts count]; i++) {
        QLProduct *product = [allproducts objectAtIndex:i];
        NSString *name = product.name;
        NSRange range = [name rangeOfString:key];
        if(range.length!=0){
            [updateProducts addObject:product];
        }
    }
    NSLog(@"%d",self.startIndex);
    return updateProducts;
}

-(NSMutableArray *)searchSpotSightProducts:(NSString *)key searchType:(QLProductType *)QLType{
    NSMutableArray *updateProducts = [[NSMutableArray alloc]init];
    QLSearchProductService* searcher = [[QLSearchProductService alloc]init];
    updateProducts = [searcher searchResult:key];
    
    return updateProducts;
}


@end
