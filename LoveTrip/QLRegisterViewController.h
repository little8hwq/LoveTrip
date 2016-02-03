//
//  QLRegisterViewController.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-5.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLProfileWebService.h"

@interface QLRegisterViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *genderText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmText;
@property (weak, nonatomic) IBOutlet UITextField *nickText;
- (IBAction)buttonPressed:(UIButton *)sender;

@end
