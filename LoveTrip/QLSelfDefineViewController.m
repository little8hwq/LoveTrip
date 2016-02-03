//
//  QLSelfDefineViewController.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-14.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLSelfDefineViewController.h"
#import "QLNavigationController.h"
#import "QLRouteWebService.h"
#import "QLProfile.h"

@interface QLSelfDefineViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scenery;
@property (weak, nonatomic) IBOutlet UILabel *traffic;
@property (weak, nonatomic) IBOutlet UILabel *hotel;
- (IBAction)makeDecision:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation QLSelfDefineViewController
@synthesize route;

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
    self.route=((QLNavigationController*)self.presentingViewController).route;
    int i = 1;
    for(QLProduct* product in self.route.products)
    {
        if (product.productType == 4) {
            self.scenery.text = [NSString stringWithFormat:@"%@ %@",self.scenery.text, product.name];
        }else if(product.productType == 3){
            self.hotel.text = [NSString stringWithFormat:@"%@ %@",self.hotel.text, product.name];
        }else if(product.productType == 2){
            [self.traffic setNumberOfLines:i];
            self.traffic.text = [NSString stringWithFormat:@"%@  %@",self.traffic.text, product.name];
            i++;
        }
    }
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

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)makeDecision:(id)sender {
    QLRouteWebService* ws = [[QLRouteWebService alloc] init];
    [self.route setName:self.nameField.text];
    [ws saveRoute:self.route user:[QLProfile getCurrProfile].userid ];
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"亲，" message:@"保存成功>_<" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    switch (buttonIndex) {
        case 0:
            [self performSegueWithIdentifier:@"selfDefineToHome" sender:self];
            NSLog(@"return");
            break;
        case 1://NO应该做的事
            break;
    }
}

@end
