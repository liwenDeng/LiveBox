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
 1.全民首页房间列表
 */
+ (NSURLSessionDataTask *)getQMHomeRoomListWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure;

@end
