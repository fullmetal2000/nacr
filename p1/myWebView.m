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
        self.opaque = NO;
        NSLog(@"mywebview init");
     //   json = [ SBJSON new ];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"webview-document" ofType:@"html"];
        [self loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
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
//  
//         [self loadRequest:request];
//
//}

- (BOOL)webView:(UIWebView *)webView2
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
	NSString *requestString = [[request URL] absoluteString];
    
    NSLog(@"request1111 : %@",requestString);
    
     if ([requestString hasPrefix:@"js-frame:"]) {
        
        NSLog(@"dddddd");
        
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        
        NSString *function = (NSString*)[components objectAtIndex:1];
//		int callbackId = [((NSString*)[components objectAtIndex:2]) intValue];
//        NSString *argsAsString = [(NSString*)[components objectAtIndex:3]
//                                  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//     
        NSArray *args = nil;//(NSArray*)[json objectWithString:argsAsString error:nil];
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
        
    } else if ([functionName isEqualToString:@"NSLog"]) {
        
      //  if ([args count]!=1) {
            NSLog(@"this is object c code!");
        //    return;
      //  }
        
        NSString *message = (NSString*)[args objectAtIndex:0];
        
    //    alertCallbackId = callbackId;
    ///    UIAlertView *alert=[[[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] autorelease];
   //     [alert show];
        
    }
    
    
    
    else {
        NSLog(@"Unimplemented method '%@'",functionName);
    }
}


@end
