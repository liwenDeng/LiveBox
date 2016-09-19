//
//  MSAPITest+QMApiTest.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "QMApiTes.h"
#import "QMBannerModel.h"
#import "MSNetworking+QMAPI.h"
#import "QMCateModel.h"
#import "QMRoomModel.h"
#import "QMRoomPlayerModel.h"

@implementation QMApiTes

- (void)testQMBannerList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getQMBannersWithSuccess:^(NSDictionary *object) {
            MSLog(@"BannerList:%@",object);
            NSArray *bannerList = [QMBannerModel mj_objectArrayWithKeyValuesArray:object[@"ios-focus"]];
            XCTAssert(bannerList.count > 0,@"全民轮播无数据！");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testQMHomeRoomList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getQMHomeRoomListWithSuccess:^(NSDictionary *object) {
            MSLog(@"HomeRoomList:%@",object);
            NSArray *list = [QMCateModel mj_objectArrayWithKeyValuesArray:object[@"list"]];
            XCTAssert(list.count > 0,@"全民房间列表分类无数据！");
            for (QMCateModel *cate in list) {
                NSString *slugName = cate.slug;
                NSArray *roomList = [QMLinkModel mj_objectArrayWithKeyValuesArray:object[slugName]];
                XCTAssert(roomList.count > 0,@"全名分类列表中某类无数据");
            }
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];
}


- (void)testQMRoomInfo {

    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getQMRoomPlayerInfoWithRoomId:@"554812" success:^(NSDictionary *object) {
            
        } failure:^(NSError *error) {
            
        }];
    }]
}
@end
