//
//  QLDetailViewController.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-10.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLDetailViewController.h"
#import "QLLogWebService.h"
#import "QLProfile.h"

@interface QLDetailViewController ()

@end

@implementation QLDetailViewController
@synthesize product;

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
    self.navigationItem.title=self.product.name;
    self.descriptionText.text=self.product.description;
    self.sourceLabel.text=self.product.source;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.chenniao.com:8085/admin/%@",product.imgUrl]]];
   self.spotImg.image=[UIImage imageWithData:data];
       [super viewDidLoad];
    // Do any additional setup after loading the view.
//    QLLogWebService*ws=[[QLLogWebService alloc]init];
//    [ws logAction:1 user:[QLProfile getCurrProfile].userid product:self.product.pid];

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
    [((QLNavigationController*)self.navigationController).route addProduct:self.product];
    QLLogWebService*ws=[[QLLogWebService alloc]init];
    [ws logAction:1 user:[QLProfile getCurrProfile].userid product:self.product.pid];
}
@end
