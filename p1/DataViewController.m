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

- (void)loadView1 {
    CGRect frame=[UIScreen mainScreen].applicationFrame;    
    self.view = [[myWebView alloc] initWithFrame:frame];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

//
    webView= [[myWebView alloc] init];
    self.view = webView;
    

    
    NSString * string1;
    string2=string1;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificatRecieved:)
                                                 name:@"testNotification" object:string1];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)notificatRecieved:(NSNotification*)notification{
    NSLog(@"Notificaiton was recieved from view 2");
    NSString *string1 = [notification object];
    NSLog(@"this is dataview controller, received notification is %@",string1);
    //create content page.
     [self loadViewControllers];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // self.dataLabel.text = [self.dataObject description];
  
    [self loadViewControllers];
    
  //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:dataObject]]];
 
    

   
}

-(void)loadViewControllers{
    
  //  NSLog(@"dataobjects=%@",dataObject);
 [webView loadHTMLString:dataObject baseURL:[NSURL URLWithString:@""]];
}

-(void)loadDetailViewControllers{
    
    //  NSLog(@"dataobjects=%@",dataObject);
    [webView loadHTMLString:dataObject baseURL:[NSURL URLWithString:@""]];
}

@end
