//
//  QLRecommendModel.h
//  LoveTrip
//
//  Created by 何文琦 on 14-6-14.
//  Copyright (c) 2014年 何文琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QLRecommendDataViewController;

@interface QLRecommendModel : NSObject<UIPageViewControllerDataSource>

- (QLRecommendDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(QLRecommendDataViewController *)viewController;

@end
