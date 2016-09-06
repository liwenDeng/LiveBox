//
//  MSAPITest.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSAPITest.h"

@implementation MSAPITest

- (dispatch_group_t)testGroup {
    if (!_testGroup) {
        _testGroup =  dispatch_group_create();
    }
    return _testGroup;
}

- (void)waitForGroup:(void(^)(dispatch_group_t group))block {
    
    __block BOOL didComplete = NO;
    
    dispatch_group_enter(self.testGroup);
    
    block(self.testGroup);
    
    dispatch_group_notify(self.testGroup, dispatch_get_main_queue(), ^{
        //所有数据请求完成;
        didComplete = YES;
    });
    
    while (! didComplete) {
        NSTimeInterval const interval = 0.002;
        if (! [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:interval]]) {
            [NSThread sleepForTimeInterval:interval];
        }
    }
    
}

- (void)testApi {

}

@end
