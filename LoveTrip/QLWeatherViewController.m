//
//  QLWeatherViewController.m
//  LoveTrip
//
//  Created by 何文琦 on 14-6-11.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import "QLWeatherViewController.h"

@interface QLWeatherViewController ()
-(void)loadWeather:(NSString*)cityName;
@end

@implementation QLWeatherViewController

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
    [self loadWeather:@"上海"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadWeather:(NSString *)cityName
{
    QLWeatherWebService*ws=[[QLWeatherWebService alloc]init];
    QLWeather*weather=[ws queryWeather:cityName];
    self.timeLabel.text=weather.lastUpdateDate;
    self.currTempLabel.text=weather.currTemp;
    self.weatherLabel.text=weather.weather;
    self.tempRangeLabel.text=weather.tempRange;
    self.windLabel.text=weather.wind;
    self.humidityLabel.text=weather.humidity;
    self.ultraLabel.text=weather.ultraviolet;
    NSString *path=[[NSBundle mainBundle] pathForResource:weather.imgUrl ofType:@"png"];
    self.weatherIcon.image=[UIImage imageWithContentsOfFile:path];
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


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self loadWeather:searchBar.text];
    [searchBar resignFirstResponder];
}


@end
