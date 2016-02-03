//
//  QLProductTableViewController.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-10.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLMasterTableViewController.h"
#import "QLNavigationController.h"
#import "QLRoute.h"

@interface QLMasterTableViewController ()

@end

@implementation QLMasterTableViewController
@synthesize types;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    QLProductType*type1=[[QLProductType alloc]init];
    type1.type=TRAFFIC;
    type1.name=@"交通";
    type1.subtitle=@"有保障的低价，支付成功100%出票";
    
    QLProductType*type2=[[QLProductType alloc]init];
    type2.type=HOTEL;
    type2.name=@"酒店";
    type2.subtitle=@"XXX家景点任您选，一张门票也优惠";
    
    QLProductType*type3=[[QLProductType alloc]init];
    type3.type=SIGHTSPOT;
    type3.name=@"景点";
    type3.subtitle=@"提供全国XXX个城市，XXX家酒店预订";
    
    self.types=[NSArray arrayWithObjects: type1,type2,type3,nil];
    ((QLNavigationController*)self.navigationController).route=[[QLRoute alloc]init];
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"typeCell" forIndexPath:indexPath];
    QLProductType*productType=[types objectAtIndex:indexPath.row];
    cell.textLabel.text=productType.name;
    cell.detailTextLabel.text=productType.subtitle;
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString:@"masterToProduct"])
     {
         QLProductTableViewController*productController=[segue destinationViewController];
         QLProductType*productType=[self.types objectAtIndex:self.tableView.indexPathForSelectedRow.row];
         productController.productType=productType;
         productController.start=0;
     }
 }


- (IBAction)buttonPressed:(UIButton *)sender {
    [self.navigationController performSegueWithIdentifier:@"masterToSelfdefine" sender:self.navigationController];
}
@end
