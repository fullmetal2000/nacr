//
//  ModelController.h
//  p4
//
//  Created by wangshu cheng on 12-10-13.
//  Copyright (c) 2012 wangshu cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetDataFromServer.h"
#import "ConvertImageToLocalUrl.h"
@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>{

 NSArray *pageContent;
 NSString *string2;
 NSArray * mainData;
     NSArray * mainPageStrings;
}
@property (strong, nonatomic) NSArray *pageContent;
- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;
-(void)notificatRecieved:(id)sender;
@end
