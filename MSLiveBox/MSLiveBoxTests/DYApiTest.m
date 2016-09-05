//
//  DYApiTest.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYApiTest.h"
#import "MSNetworking+DYAPI.h"
#import "msconsts.h"

@interface DYApiTest ()

@property (nonatomic) dispatch_group_t testGroup;

@end

@implementation DYApiTest

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

/**
 *  轮播图
 */
- (void)testBannerList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getDouyuSlideBanners:^(NSDictionary *object) {
            NSLog(@"Res:%@",object);
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"Fail:%@",error);
            dispatch_group_leave(group);
        }];
    }];
}


- (dispatch_group_t)testGroup {
    if (!_testGroup) {
        _testGroup =  dispatch_group_create();
    }
    return _testGroup;
}

@end


