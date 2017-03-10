//
//  MSNetworking+PandaAPI.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/19.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSNetworking.h"

@interface MSNetworking (PandaAPI)

/**
 *  1.熊猫首页轮播图
 */
+ (NSURLSessionDataTask *)getPandaBannersWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  2.熊猫首页房间列表
 */
+ (NSURLSessionDataTask *)getPandaHomeRoomListWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  3.熊猫房间信息
 */
+ (NSURLSessionDataTask *)getPandaRoomPlayerInfoWithRoomId:(NSString *)roomId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  4.熊猫全部直播列表
 *  从1 开始
 */
+ (NSURLSessionDataTask *)getPandaAllLiveListWithPageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  5.熊猫分类下直播列表
 *  cateId: PDSectionModel->ename
 */
+ (NSURLSessionDataTask *)getPandaAllLiveListWithCateId:(NSString*)cateId pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

#pragma mark - 分类
/**
 分类列表
 */
+ (NSURLSessionDataTask *)getPandaCommonCates:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

#pragma mark - 搜搜
+ (NSURLSessionDataTask *)pd_searchRoomListKeyword:(NSString *)keyword pageNo:(NSInteger)pageNo isLive:(BOOL)isLive success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end
