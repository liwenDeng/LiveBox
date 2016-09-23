//
//  PDApiTest.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/23.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "PDApiTest.h"
#import "MSNetworking+PandaAPI.h"
#import "PDBannerModel.h"
#import "PDRoomModel.h"
#import "PDRoomPlayerModel.h"

@implementation PDApiTest

- (void)testPDBannerList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getPandaBannersWithSuccess:^(NSDictionary *object) {
            MSLog(@"BannerList:%@",object);
            NSArray *bannerList = [PDBannerModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            XCTAssert(bannerList.count > 0,@"熊猫轮播无数据！");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testPDHomeRoomList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getPandaHomeRoomListWithSuccess:^(NSDictionary *object) {
            MSLog(@"HomeRoomList:%@",object);
            NSArray *homeRoomList = [PDRoomSectionModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            XCTAssert(homeRoomList.count > 0,@"熊猫首页无数据！");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testPDRoomInfo {
    [self waitForGroup:^(dispatch_group_t group) {
       [MSNetworking getPandaRoomPlayerInfoWithRoomId:@"485118" success:^(NSDictionary *object) {
           MSLog(@"HomeRoomList:%@",object);
           PDRoomPlayerModel *playerModel = [PDRoomPlayerModel mj_objectWithKeyValues:object[@"data"][@"info"]];
           dispatch_group_leave(group);
       } failure:^(NSError *error) {
           dispatch_group_leave(group);
       }];
    }];
}

- (void)testPDAllLiveRooms {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getPandaAllLiveListWithPageNo:1 success:^(NSDictionary *object) {
            MSLog(@"HomeRoomList:%@",object);
            NSArray *roomList = [PDRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"][@"items"]];
            XCTAssert(roomList.count > 0,@"熊猫全部直播无数据！");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
           
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testCateRoomList {
    [self waitForGroup:^(dispatch_group_t group) {
        //传 ename
        [MSNetworking getPandaAllLiveListWithCateId:@"lol" pageNo:1 success:^(NSDictionary *object) {
            MSLog(@"HomeRoomList:%@",object);
            NSArray *roomList = [PDRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"][@"items"]];
            XCTAssert(roomList.count > 0,@"熊猫全部直播无数据！");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

@end
