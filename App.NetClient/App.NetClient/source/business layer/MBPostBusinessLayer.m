//
//  MBPostBusinessLayer.m
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 23/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import "MBPostBusinessLayer.h"
#import "MBUserRepository.h"
#import "MBTimelineParser.h"
#import "MBPostViewObject.h"

@implementation MBPostBusinessLayer

- (void)fetchNewPosts:(void(^)(NSArray *arrayOfResult))completionBlock
{
    if (completionBlock) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [MBUserRepository fetchUserTimelineWithCompletionBlock:^(NSDictionary *dictionaryOfTimeline) {
                NSArray *arrayOfResult = [MBTimelineParser postsFromTimelineDictionary:dictionaryOfTimeline];
                
                //sort array for most recent first
                NSArray *sortedArrayOfResult;
                if (arrayOfResult) {
                    sortedArrayOfResult = [arrayOfResult sortedArrayUsingComparator:^NSComparisonResult(MBPostViewObject * obj1, MBPostViewObject * obj2) {
                        return [obj2.createdAt compare:obj1.createdAt];
                    }];
                }
                
                completionBlock(sortedArrayOfResult);
            }];
        });
    }
}
@end
