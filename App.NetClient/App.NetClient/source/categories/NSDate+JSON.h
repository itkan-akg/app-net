//
//  NSDate+JSON.h
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 24/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JSON)
+ (NSDate*)dateFromJSONDateString:(NSString*)dateString;
@end
