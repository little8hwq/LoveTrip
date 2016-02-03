//
//  QLProductTableViewController.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-10.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLProductType.h"
#import "QLProduct.h"
#import "QLProductService.h"
#import "QLDetailViewController.h"
#import "QLSearchProducts.h"
#import "QLRoute.h"

@interface QLProductTableViewController : UITableViewController<UISearchBarDelegate>

@property QLProductType* productType;
@property NSMutableArray* products;
@property int start;
@property QLSearchProducts* searcher;

@end
