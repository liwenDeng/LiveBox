//
//  MSAPITest.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "msconsts.h"
#import <MJExtension.h>


@interface MSAPITest : XCTestCase

@property (nonatomic) dispatch_group_t testGroup;

- (void)waitForGroup:(void(^)(dispatch_group_t group))block;

@end
