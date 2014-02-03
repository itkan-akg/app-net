//
//  MBUserRepository.m
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 23/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import "MBUserRepository.h"
#import "MBServiceConstants.h"
#import "NSDictionary+JSON.h"

@implementation MBUserRepository
+ (void)fetchUserTimelineWithCompletionBlock:(void(^)(NSDictionary *dictionaryOfTimeline))completionBlock
{
    if (completionBlock) {
        NSDictionary *dictionaryOfResult = [NSDictionary dictionaryWithContentsOfJSONURLString:constTimelineURLString];
        completionBlock(dictionaryOfResult);
    }
}
@end
