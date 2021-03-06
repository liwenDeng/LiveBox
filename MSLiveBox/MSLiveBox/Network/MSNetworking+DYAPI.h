//
//  MSNetworking+DYAPI.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSNetworking.h"

@interface MSNetworking (DYAPI)

/**
 1.获取斗鱼首页最热数据
 * 返回是DYRoomModel 数组
 */
+ (NSURLSessionDataTask *)getDouyuBigDataInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 2.获取斗鱼首页颜值数据
 */
+ (NSURLSessionDataTask *)getDouyuFaceInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 3.获取斗鱼首页热门分类房间列表数据 getHotCate
 */
+ (NSURLSessionDataTask *)getDouyuHotCateListInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  4.获取分类直播列表
 *  @param cateId  分类id
 */
+ (NSURLSessionDataTask *)getDouyuLiveCateId:(NSInteger)cateId limit:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  5.获取颜值类播放列表
 */
+ (NSURLSessionDataTask *)getFaceRoomListLimit:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

/**
 *  6.获取首页轮播图
 */
+ (NSURLSessionDataTask *)getDouyuSlideBanners:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

#pragma mark - 所有直播
/**
 获取斗鱼当前全部直播
 *  @param limit 一次获取多少条数据
 *  @param offset 从第几条数据开始获取
 */
+ (NSURLSessionDataTask *)getAllDouyuLiveLimit:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

#pragma mark - 搜索
/**
 通过关键字搜索 （如果关键字是数字，还会调用搜索roomId的方法）

 @param keyword 关键字
 @param limit   一页数量
 @param offset  偏移量（从第几个开始）
 */
+ (NSURLSessionDataTask *)getDouyuRoomListWithKeyword:(NSString *)keyword limit:(NSInteger)limit offset:(NSInteger)offset success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

+ (NSURLSessionDataTask *)getDouyuRoomListRoomId:(NSString *)roomId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure;


#pragma mark - 分类
/**
 分类列表
 */
+ (NSURLSessionDataTask *)getDouyuCommonCates:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end
