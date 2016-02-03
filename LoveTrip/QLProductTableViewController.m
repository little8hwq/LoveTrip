//
//  QLProductTableViewController.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-10.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLProductTableViewController.h"

@interface QLProductTableViewController ()

@end
static const int SIZE=10;
@implementation QLProductTableViewController
@synthesize productType;
@synthesize products;
@synthesize start;
@synthesize searcher;

bool isSearch = NO;
bool searchHotel = NO;

NSString *searchKey;

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
    QLProductService*ws =[[QLProductService alloc] init];
    self.products=[ws queryAllWithType:self.productType.type start:self.start size:SIZE];
    self.navigationItem.title=self.productType.name;
    self.start+=SIZE;
    
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    searcher = [[QLSearchProducts alloc]init];
    searcher.startIndex = 0;
    
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
    if (searchHotel) {
        return [self.products count];
    }
    return ([self.products count]+1);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //加入一个cell做加载
    if([indexPath row] == [products count] && !searchHotel){
        UITableViewCell *loadCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        
        loadCell.textLabel.text = @"点击加载更多";
        return loadCell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
    QLProduct*product=[self.products objectAtIndex:indexPath.row];
    cell.textLabel.text=product.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"¥%.2f",product.price];
    return cell;
}

//加载cell被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row]==[products count]){
        [tableView cellForRowAtIndexPath:indexPath].textLabel.text = @"努力加载中……";
        if (isSearch) {
            [self performSelectorInBackground:@selector(searchMoreCell) withObject:nil];
        }else{
            [self performSelectorInBackground:@selector(loadMoreCell) withObject:nil];
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

//插入更多cell
-(void)loadMoreCell{
    QLProductService*ws =[[QLProductService alloc] init];
    NSMutableArray *newproducts = [[NSMutableArray alloc]init];
    newproducts=[ws queryAllWithType:self.productType.type start:self.start size:SIZE];
    self.start+=SIZE;
    [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:newproducts waitUntilDone:NO];
}

//查找更多cell，根据type调用不同方法
-(void)searchMoreCell{
    NSMutableArray *updateProducts = [[NSMutableArray alloc]init];
    if(self.productType.type == 2){
        updateProducts = [searcher searchTrafficProducts:searchKey searchType:self.productType];
        
       [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:updateProducts waitUntilDone:NO];
    }else if(self.productType.type == 3){
        updateProducts = [searcher searchHotelProducts:searchKey searchType:self.productType];
        [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:updateProducts waitUntilDone:NO];
    }
}

//将更新过的数据插入table
-(void)appendTableWith:(NSMutableArray *)newProducts{
    for (int i=0;i<[newProducts count];i++) {
        [self.products addObject:[newProducts objectAtIndex:i]];
    }
    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc]init];
    for (int ind = 0; ind < [newProducts count]; ind++) {
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:[self.products indexOfObject:[newProducts objectAtIndex:ind]] inSection:0];
        [insertIndexPaths addObject:newPath];
    }
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];

}

//重置table
-(void)replaceTableWith: (NSMutableArray *)newProducts{
    [self.products removeAllObjects];
    for (int i=0;i<[newProducts count];i++) {
        [self.products addObject:[newProducts objectAtIndex:i]];
    }
    [self.tableView reloadData];
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
    if(self.tableView.indexPathForSelectedRow.row <[products count]){
        QLDetailViewController*detailController=[segue destinationViewController];
        QLProduct*product=[self.products objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        detailController.product=product;
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    searchKey = searchBar.text;
    isSearch = YES;
    searcher.startIndex = 0;
    searcher.searchName = YES;
    NSMutableArray *updateProducts = [[NSMutableArray alloc] init];
    if(self.productType.type == 2){
        searchHotel = NO;
        updateProducts = [searcher searchTrafficProducts:searchBar.text searchType:self.productType];
        [self replaceTableWith:updateProducts];
    }else if(self.productType.type == 3){
        searchHotel = YES;
        updateProducts = [searcher searchHotelProducts:searchBar.text searchType:self.productType];
        [self replaceTableWith:updateProducts];
    }else if(self.productType.type == 4){
        searchHotel = YES;
        updateProducts = [searcher searchSpotSightProducts:searchBar.text searchType:self.productType];
        [self replaceTableWith:updateProducts];
    }
    searchHotel = NO;
    [searchBar resignFirstResponder];
}






@end
