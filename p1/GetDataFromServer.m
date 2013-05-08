//
//  GetDataFromServer.m
//  p1
//
//  Created by wangshu cheng on 12-11-11.
//  Copyright (c) 2012 wangshu cheng. All rights reserved.
//

/*This class is to get jason data from server, will return a newsRec array */

#import "GetDataFromServer.h"

@implementation GetDataFromServer

/*This function rebuild a newsRecord object array from original dataArray*/

/*This function get original data array from server*/
- (NSArray *)getJasonData:(NSString*)serverUrl forkey:(NSString*)serverKey {    
    
    //get url
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:
                     serverUrl]];
    /* sample url for test: http://cnewsfinder.appspot.com/
     http://api.kivaws.org/v1/loans/search.json?status=fundraising"*/
    
    //Use NSJSONSerialization to parse the JSON data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data //1
                          
                          options:kNilOptions
                          error:&error];
    
    //retieve data for a given key
    NSArray* dataArray = [json  objectForKey:serverKey]; //2
    
    //below for test purpose
//    NSDictionary* newsRec=[dataArray objectAtIndex:0]; //3
//    NSLog(@"url=%@\n",[newsRec objectForKey:@"url"]);
//    NSLog(@"title=%@",[newsRec objectForKey:@"title"]);

    return dataArray;

}



@end
