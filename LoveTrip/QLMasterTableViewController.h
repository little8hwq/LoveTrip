//
//  QLMasterTableViewController.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-10.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLProductType.h"
#import "QLProductTableViewController.h"
#import "QLRoute.h"

@interface QLMasterTableViewController : UITableViewController

@property NSArray* types;

- (IBAction)buttonPressed:(UIButton *)sender;

@end
