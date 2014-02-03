//
//  MBPostViewObject.h
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 23/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBPostViewObject : NSObject
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@end
