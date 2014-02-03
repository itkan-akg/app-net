//
//  NSDictionary+JSON.m
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 23/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)
+ (NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSDictionary *dictionaryOfResult = nil;
    
    NSData* dataFromURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlAddress]];
    if (dataFromURL) {
        dictionaryOfResult = [NSJSONSerialization JSONObjectWithData:dataFromURL options:kNilOptions error:nil];
    }
    
    return dictionaryOfResult;
}
@end
