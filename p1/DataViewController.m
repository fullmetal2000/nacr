//
//  DataViewController.m
//  p1
//
//  Created by wangshu cheng on 12-10-13.
//  Copyright (c) 2012 wangshu cheng. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController
@synthesize webView, dataObject;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
    [webView loadHTMLString:dataObject
                    baseURL:[NSURL URLWithString:@""]];
    
}

- (IBAction)handle_setting_btn:(id)sender {
    
    NSLog(@"setting entered");
}

- (IBAction)handle_home_btn:(id)sender {
    
    
    
}
@end
