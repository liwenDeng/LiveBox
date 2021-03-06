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
#import "QMCommonCate.h"

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
        [MSNetworking getQMRoomPlayerInfoWithRoomId:@"1312406" success:^(NSDictionary *object) {
            QMRoomPlayerModel *playerModel = [QMRoomPlayerModel mj_objectWithKeyValues:object];
            NSLog(@"finished");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
    
}

- (void)testCateRoomList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getQMRoomCateListWithCateName:@"lol" success:^(NSDictionary *object) {
            NSArray *roomList = [QMRoomPlayerModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            XCTAssert(roomList.count > 0,@"全名分类列表中某类无数据");
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testAllLiveRoomList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getQMAllLiveRoomsPageNo:1 success:^(NSDictionary *object) {
            
            NSInteger total = [object[@"total"] integerValue]; //总共数据
            NSInteger page = [object[@"page"] integerValue]; //当前页码 
            NSInteger pageCount = [object[@"pageCount"] integerValue]; //总页数
            NSInteger size = [object[@"size"] integerValue];    //一页数量
            NSArray *roomList = [QMRoomPlayerModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
            
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];
}

- (void)testQMCommonCateList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking getQMCommonCates:^(NSDictionary *object) {
            NSArray *cateList = [QMCommonCate mj_objectArrayWithKeyValuesArray:object];
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];

}

- (void)testSearchList {
    [self waitForGroup:^(dispatch_group_t group) {
        [MSNetworking qm_searchRoomListKeyword:@"小智" pageNo:1 isLive:YES success:^(NSDictionary *object) {
            NSArray *cateList = [QMRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"][@"items"]];
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
            dispatch_group_leave(group);
        }];
    }];
}

@end
