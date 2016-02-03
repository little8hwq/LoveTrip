//
//  QLRecommendDataViewController.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-14.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLRecommendDataViewController.h"
#import "QLRouteWebService.h"
#import "QLProfile.h"

@interface QLRecommendDataViewController ()

@end

@implementation QLRecommendDataViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject name];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.chenniao.com:8085/admin/%@",[self.dataObject getProduct:0].imgUrl]]];
    self.spotImage.image=[UIImage imageWithData:data];
    
    [self.products setNumberOfLines:0];
    [self.value setNumberOfLines:0];
    [self.value sizeToFit];
    [self.products sizeToFit];

    NSString* labelText = [[NSString alloc] init];
    NSString* labelValue = [[NSString alloc] init];
    float sum = 0;
    for (int i = 0; i < [self.dataObject.products count]; i++) {
        labelText = [NSString stringWithFormat:@"%@\n%@",labelText,[[self.dataObject getProduct:i] name]];
        labelValue = [NSString stringWithFormat:@"%@\n¥%.2f",labelValue,[[self.dataObject getProduct:i] price]];
        sum += [[self.dataObject getProduct:i] price];
//        NSLog(@"%@",labelText);
        
    }
    self.products.text = [NSString stringWithFormat:@"%@\n总价",labelText];
    
    self.value.text = [NSString stringWithFormat:@"%@\n¥%.2f",labelValue,sum];
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


- (IBAction)homeButtonPressed:(id)sender {
    [self.parentViewController.parentViewController performSegueWithIdentifier:@"recommedToHome" sender:self.parentViewController.parentViewController];
}

- (IBAction)lovePressed:(id)sender {
    QLRouteWebService* ws=[[QLRouteWebService alloc]init];
    [ws saveRoute:self.dataObject user:[QLProfile getCurrProfile].userid];
}
@end
