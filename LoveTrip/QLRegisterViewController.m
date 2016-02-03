//
//  QLRegisterViewController.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-5.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLRegisterViewController.h"

@interface QLRegisterViewController ()

@end

@implementation QLRegisterViewController

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
    NSString*username=self.usernameText.text;
    NSString*password=self.passwordText.text;
    NSString*gender=self.genderText.text;
    NSString*nick=self.nickText.text;
    QLProfileWebService* ws=[[QLProfileWebService alloc]init];
    int userid=[ws registerWithName:username password:password gender:gender nick:nick];
    if(userid>0)
        [self performSegueWithIdentifier:@"registerToLogin" sender:self];
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
