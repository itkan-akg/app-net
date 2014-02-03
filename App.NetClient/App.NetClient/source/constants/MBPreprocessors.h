//
//  MBPreprocessors.h
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 24/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#ifndef App_NetClient_MBPreprocessors_h
#define App_NetClient_MBPreprocessors_h

#pragma mark - System Versioning Preprocessor Macros
/*
 if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
 ...
 }
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif
