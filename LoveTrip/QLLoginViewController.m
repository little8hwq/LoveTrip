//
//  QLLoginViewController.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-5.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLLoginViewController.h"

@interface QLLoginViewController ()

@end

@implementation QLLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.passwordText.secureTextEntry=YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonPressed:(UIButton *)sender
{
    NSString* username=self.usernameText.text;
    NSString* password=self.passwordText.text;
    NSLog(@"%@,%@",username,password);
    QLProfileWebService*ws=[[QLProfileWebService alloc]init];
    QLProfile* profile=[ws loginWithName:username password:password];
    if(profile)
    {
        [QLProfile setCurrProfile:profile];
        [self performSegueWithIdentifier:@"loginToHome" sender:self];
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
