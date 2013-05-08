//
//  RootViewController.h
//  p1
//
//  Created by wangshu cheng on 12-10-13.
//  Copyright (c) 2012 wangshu cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>{
    
    
    IBOutlet UIView *menuView;
    NSString *string2;
    int currentpage;
}

@property (strong, nonatomic) UIPageViewController *pageViewController;
- (IBAction)handle_home_btn:(id)sender;
- (IBAction)handle_setting_btn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *pageCount;
@property (strong, nonatomic) IBOutlet UILabel *pageNum;
@end
