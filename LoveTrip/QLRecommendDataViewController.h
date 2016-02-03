//
//  QLRecommendDataViewController.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-14.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLRoute.h"

@interface QLRecommendDataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UIImageView *spotImage;
@property (strong, nonatomic) QLRoute* dataObject;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)lovePressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *products;
@property (weak, nonatomic) IBOutlet UILabel *value;

@end
