//
//  QLDetailViewController.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-10.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLProduct.h"
#import "QLRoute.h"
#import "QLNavigationController.h"

@interface QLDetailViewController : UIViewController
- (IBAction)buttonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *spotImg;

@property QLProduct*product;

@end
