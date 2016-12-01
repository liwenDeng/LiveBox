//
//  MSNetworking+QMAPI.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSNetworking.h"

@interface MSNetworking (QMAPI)

/**
 1.全民首页轮播图
 */
+ (NSURLSessionDataTask *)getQMBannersWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 2.全民首页房间列表
 */
+ (NSURLSessionDataTask *)getQMHomeRoomListWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  3.全民房间信息
 */
+ (NSURLSessionDataTask *)getQMRoomPlayerInfoWithRoomId:(NSString *)roomId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  4.全民分类房间列表
 *  @param cateName  分类名称 --> slugName
 */
+ (NSURLSessionDataTask *)getQMRoomCateListWithCateName:(NSString *)cateName success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  5.全民所有直播房间列表
 */
+ (NSURLSessionDataTask *)getQMAllLiveRoomsPageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

#pragma mark - 分类
/**
 分类列表
 */
+ (NSURLSessionDataTask *)getQMCommonCates:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end
