//
//  GetDataFromServer.h
//  p1
//
//  Created by wangshu cheng on 12-11-11.
//  Copyright (c) 2012 wangshu cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDataFromServer : NSObject{

    //Array of news records
    NSArray *newsRecArray;
    NSString * key;
    NSString * url;
    
}
-(NSArray *)getJasonData:(NSString*)serverUrl forkey:(NSString*)serverKey;

@end
