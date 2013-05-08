//
//  DataViewController.h
//  p1
//
//  Created by wangshu cheng on 12-10-13.
//  Copyright (c) 2012 wangshu cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myWebView.h"
@interface DataViewController : UIViewController{
     NSString *string2;
    
}

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) IBOutlet myWebView *webView ;

@end
