//
//  QLLoginViewController.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-5.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLProfileWebService.h"
@interface QLLoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

- (IBAction)buttonPressed:(UIButton *)sender;

@end
