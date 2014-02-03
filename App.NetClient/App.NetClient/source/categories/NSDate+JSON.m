//
//  NSDate+JSON.m
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 24/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import "NSDate+JSON.h"

@implementation NSDate (JSON)

+ (NSDateFormatter*)jsonDateFormatter {
    static NSDateFormatter* dateFormatter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    });
    
    return dateFormatter;
}

+ (NSDate*)dateFromJSONDateString:(NSString*)dateString
{
    NSDate *date;
    
    date = [[NSDate jsonDateFormatter] dateFromString:dateString];
    
    return date;
}
@end
