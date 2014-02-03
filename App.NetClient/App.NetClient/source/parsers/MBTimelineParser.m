//
//  MBTimelineParser.m
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 23/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import "MBTimelineParser.h"
#import "MBServiceConstants.h"
#import "MBPostViewObject.h"
#import "NSDate+JSON.h"

@implementation MBTimelineParser
+ (NSArray*)postsFromTimelineDictionary:(NSDictionary *)dictionaryOfTimeline
{
    NSMutableArray *arrayOfPosts = nil;
    
    if (!dictionaryOfTimeline) {
        return nil;
    }
    
    id arrayOfPostDictionary = dictionaryOfTimeline[kPosts];
    
    if ([arrayOfPostDictionary isKindOfClass:[NSArray class]]) {
        arrayOfPosts = [[NSMutableArray alloc] initWithCapacity:[arrayOfPostDictionary count]];
        for (NSDictionary* postDictionary in arrayOfPostDictionary) {
            MBPostViewObject *postObject = [MBTimelineParser postFromDictionary:postDictionary];
            [arrayOfPosts addObject:postObject];
        }
    }
    
    return arrayOfPosts;
}

#pragma mark - private methods
+ (MBPostViewObject*)postFromDictionary:(NSDictionary*)postDictionary
{
    MBPostViewObject *postObject = nil;
    
    if (!postDictionary) {
        return nil;
    }
    
    NSDictionary *userDictionary = postDictionary[kUser];
    
    postObject = [[MBPostViewObject alloc] init];
    postObject.username = userDictionary[kUsername];
    postObject.imageURLString = userDictionary[kAvatar][kURL];
    postObject.text = userDictionary[kDescription][kText];
    postObject.createdAt = [NSDate dateFromJSONDateString:userDictionary[kCreatedAt]];
    return postObject;
}
@end
