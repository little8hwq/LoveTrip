//
//  QLRouteDetailViewController.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-16.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLRouteDetailViewController.h"

@interface QLRouteDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UILabel *valueText;
@property (weak, nonatomic) IBOutlet UILabel *products;


@end

@implementation QLRouteDetailViewController

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
    self.navigationItem.title=self.route.name;
    self.descriptionText.text=[[self.route getProduct:0] description];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.chenniao.com:8085/admin/%@",[self.route getProduct:0].imgUrl]]];
    self.image.image=[UIImage imageWithData:data];
    
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

    [self.products setNumberOfLines:0];
    [self.valueText setNumberOfLines:0];
    [self.valueText sizeToFit];
    [self.products sizeToFit];
    
    NSString* labelText = [[NSString alloc] init];
    NSString* labelValue = [[NSString alloc] init];
    float sum = 0;
    for (int i = 0; i < [self.route.products count]; i++) {
        labelText = [NSString stringWithFormat:@"%@\n%@",labelText,[[self.route getProduct:i] name]];
        labelValue = [NSString stringWithFormat:@"%@\n¥%.2f",labelValue,[[self.route getProduct:i] price]];
        sum += [[self.route getProduct:i] price];
//        NSLog(@"%f", sum);
        
    }
    self.products.text = [NSString stringWithFormat:@"%@\n总价",labelText];
    
    self.valueText.text = [NSString stringWithFormat:@"%@\n¥%.2f",labelValue,sum];
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

@end
