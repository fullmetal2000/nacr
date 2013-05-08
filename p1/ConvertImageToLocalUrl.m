//
//  ConvertImageToLocalUrl.m
//  p1
//
//  Created by wangshu cheng on 13-01-13.
//  Copyright (c) 2013 wangshu cheng. All rights reserved.
//

#import "ConvertImageToLocalUrl.h"

@implementation ConvertImageToLocalUrl

-(NSArray *)saveImageToLocal:(NSArray*)imageArray{
    NSMutableArray * localImageUrl = [[NSMutableArray alloc] init];
    
    for (NSString * stringURL in imageArray){
        
        NSLog(@"stringURL=%@",stringURL);
        NSLog(@"len=%u",[imageArray count]);
        // save url to local:
       // NSString *stringURL = @"http://www.somewhere.com/thefile.png";
        NSURL  *url = [NSURL URLWithString:stringURL];
        NSLog(@"1");
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        NSLog(@"2");
        if ( urlData )
        {
                   NSLog(@"3");
            NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                   NSLog(@"4");
            NSString  *documentsDirectory = [paths objectAtIndex:0];
                   NSLog(@"5");
            NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"test1324.png"];
            NSLog(@"%@",documentsDirectory);
                   NSLog(@"6");
            [urlData writeToFile:filePath atomically:YES];
              NSLog(@"filepath=%@",filePath);
            [localImageUrl addObject:filePath];
             NSLog(@"7");
        }
        
    
    }
    return localImageUrl;
}

@end
