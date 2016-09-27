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
#import "DYBannerModel.h"
#import "DYRoomModel.h"
#import <MJExtension.h>
#import "MSBaseBannerModel.h"

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
            MSLog(@"Res:%@",object);
            NSArray *bannerList = [DYBannerModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            XCTAssertTrue([bannerList[0] isMemberOfClass:[DYBannerModel class]],@"fail");
            DYBannerModel *DYmodel = bannerList[0];
            MSBaseBannerModel *model = [DYmodel convertToBannerModel];
            XCTAssertNotNil(model,@"fail");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            NSLog(@"Fail:%@",error);
            dispatch_group_leave(group);
        }];
    }];
}

/**
 *  首页数据
 */
- (void)testHomeRequest {
    [self waitForGroup:^(dispatch_group_t group) {
       [MSNetworking getDouyuBigDataInfos:^(NSDictionary *object) {
           MSLog(@"热门推荐Res:%@",object);
           NSArray *roomList = [DYRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
           XCTAssert(roomList.count > 0,@"没有数据");
           DYRoomModel *dyModel = roomList[0];
           MSRoomCellModel *model = [dyModel convertToCellModel];
           XCTAssertNotNil(model,@"fail");
           dispatch_group_leave(group);
       } failure:^(NSError *error) {
           
           dispatch_group_leave(group);
       }];
    }];
    
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getDouyuFaceInfos:^(NSDictionary *object) {
            MSLog(@"颜值Res:%@",object);
            NSArray *roomList = [DYRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            XCTAssert(roomList.count > 0,@"没有数据");
            DYRoomModel *dyModel = roomList[0];
            MSRoomCellModel *model = [dyModel convertToCellModel];
            XCTAssertNotNil(model,@"fail");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
    
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getDouyuHotCateListInfos:^(NSDictionary *object) {
            MSLog(@"热门分类Res:%@",object);
            NSArray *cateList = [DYRoomCateList mj_objectArrayWithKeyValuesArray:object[@"data"]];
            XCTAssert(cateList.count > 0, @"没有分类数据");
            DYRoomCateList *cate = cateList[0];
            DYRoomModel *model = cate.room_list[0];
            MSLog(@"tag:%@",cate.tag_name);
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
           
            dispatch_group_leave(group);
        }];
    }];
}


- (void)testCateList {
    http://capi.douyucdn.cn/api/v1/live/1?limit=20&client_sys=ios&offset=0
    
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getDouyuLiveCateId:1 limit:20 offset:0 WithSuccess:^(NSDictionary *object) {
            NSArray *roomList = [DYRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            XCTAssert(roomList.count > 0, @"某分类房间数为0");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
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


