//
//  myWebView.h
//  p1
//
//  Created by wangshu cheng on 12-12-02.
//  Copyright (c) 2012 wangshu cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"

@interface myWebView : UIWebView <UIWebViewDelegate> {
    SBJSON *json;
   
}
- (void)myLoadRequest:(NSURLRequest *)request;

@end
