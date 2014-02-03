//
//  MBPostBusinessLayer.h
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 23/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBPostBusinessLayer : NSObject

// arrayOfResult is an array of MBPostViewObject
- (void)fetchNewPosts:(void(^)(NSArray *arrayOfResult))completionBlock;
@end
