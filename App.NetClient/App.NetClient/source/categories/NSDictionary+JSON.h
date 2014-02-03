//
//  NSDictionary+JSON.h
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 23/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)
+ (NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
@end
