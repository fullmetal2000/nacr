//
//  myWebView.m
//  p1
//
//  Created by wangshu cheng on 12-12-02.
//  Copyright (c) 2012 wangshu cheng. All rights reserved.
//

#import "myWebView.h"

@implementation myWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.opaque = YES;
        NSLog(@"mywebview init");
        json = [ SBJSON new ];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"webview-document" ofType:@"html"];
//       [self loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
       }
    return self;
 
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//- (void)myLoadRequest:(NSURLRequest *)request{
//    
//    NSLog(@"ddfds");
//   self.delegate = self;
//    
//  [self loadRequest:request];
//  }

- (BOOL)webView:(UIWebView *)webView2
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
	NSString *requestString = [[request URL] absoluteString];
    
    NSLog(@"request1111 : %@",requestString);
    
     if ([requestString hasPrefix:@"js-frame:"]) {
        
            
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        
        NSString *function = (NSString*)[components objectAtIndex:1];
//		int callbackId = [((NSString*)[components objectAtIndex:2]) intValue];
        NSString *argsAsString = [(NSString*)[components objectAtIndex:3]
                                  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//     
        NSArray *args = (NSArray*)[json objectWithString:argsAsString error:nil];
        NSLog(@"function,%@",function);
        [self handleCall:function callbackId:0 args:args];
        
       return NO;
    }
    
    return YES;
}

- (void)handleCall:(NSString*)functionName callbackId:(int)callbackId args:(NSArray*)args
{
    NSLog(@"handlecall called");
    if ([functionName isEqualToString:@"setBackgroundColor"]) {
        
        if ([args count]!=3) {
            NSLog(@"setBackgroundColor wait exactly 3 arguments!");
            return;
        }
        NSNumber *red = (NSNumber*)[args objectAtIndex:0];
        NSNumber *green = (NSNumber*)[args objectAtIndex:1];
        NSNumber *blue = (NSNumber*)[args objectAtIndex:2];
        NSLog(@"setBackgroundColor(%@,%@,%@)",red,green,blue);
        self.backgroundColor = [UIColor colorWithRed:[red floatValue] green:[green floatValue] blue:[blue floatValue] alpha:1.0];
    //    [self returnResult:callbackId args:nil];
        
    } else if ([functionName isEqualToString:@"section"]) {
        
        if ([args count]!=1) {
            NSLog(@" section selector take 1 arguments");
            return;
        }
          // send notification to model controller.m
        //post the notification
        NSString *message = (NSString*)[args objectAtIndex:0];
        NSLog(@"message=%@",message);
        
        NSString *string1 = message;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"testNotification" object:string1];
        
        
    }
    else if ([functionName isEqualToString:@"loadDetail"]) {
        NSLog(@"this is load detain fun");
        if ([args count]!=6) {
            NSLog(@" section selector take 6 arguments");
            return;
        }
        NSString *idx = (NSString*)[args objectAtIndex:0];
        NSString *img = (NSString*)[args objectAtIndex:1];
        NSString *title = (NSString*)[args objectAtIndex:2];
        NSString *author = (NSString*)[args objectAtIndex:3];
        NSString *time = (NSString*)[args objectAtIndex:4];
        NSString *article = (NSString*)[args objectAtIndex:5];
        
        NSString *string1 = idx;
         string1 = [[string1 stringByAppendingString:@"#30714_2012c#"] stringByAppendingString:img];
        string1 = [[string1 stringByAppendingString:@"#30714_2012c#"] stringByAppendingString:title];
        string1 = [[string1 stringByAppendingString:@"#30714_2012c#"] stringByAppendingString:author];
        string1 = [[string1 stringByAppendingString:@"#30714_2012c#"] stringByAppendingString:time];
        string1 = [[string1 stringByAppendingString:@"#30714_2012c#"] stringByAppendingString:article];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"detailNewsNotification" object:string1];
        // do sth with the newsid, e.g. send notification to dataviewcontroller, try to create a new viewcontroller, and load detail artical.
    }
    else if ([functionName isEqualToString:@"goback"]) {

        if ([args count]!=1) {
            NSLog(@" section selector take 1 arguments");
            return;
        }
          NSString *message = (NSString*)[args objectAtIndex:0];
       
        NSLog(@"goback idx: %@",message);
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"backToMainNotification" object:message];
        // do sth with the newsid, e.g. send notification to dataviewcontroller, try to create a new viewcontroller, and load detail artical.
    }
    
    else {
        NSLog(@"Unimplemented method '%@'",functionName);
    }
}


@end
