//
//  MSNetworking+QMAPI.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSNetworking+QMAPI.h"
#import "NSDate+MSExtension.h"

@implementation MSNetworking (QMAPI)

+ (NSURLSessionDataTask *)getQMBannersWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    // object[@"ios-focus"];
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"http://www.quanmin.tv/json/page/app-data/info.json"];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getQMHomeRoomListWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://www.quanmin.tv/json/page/ios-index/info.json?0904131025
    //09 04 13 10 05
    NSDate *date = [NSDate date];
    NSInteger month = date.ms_month;
    NSInteger day = date.ms_day;
    NSInteger hour = date.ms_hour;
    NSInteger minute = date.ms_minute;
    NSInteger second = date.ms_seconds;
    
    NSString *timeString = [NSString stringWithFormat:@"%02ld%02ld%02ld%02ld%02ld",month,day,hour,minute,second];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.quanmin.tv/json/page/ios-index/info.json?%@",timeString];
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:urlStr];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//3.获取房间信息及房间video
//http://www.quanmin.tv/json/rooms/554812/info.json?0913165439
+ (NSURLSessionDataTask *)getQMRoomPlayerInfoWithRoomId:(NSString *)roomId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    NSDate *date = [NSDate date];
    NSInteger month = date.ms_month;
    NSInteger day = date.ms_day;
    NSInteger hour = date.ms_hour;
    NSInteger minute = date.ms_minute;
    NSInteger second = date.ms_seconds;
    
    NSString *timeString = [NSString stringWithFormat:@"%02ld%02ld%02ld%02ld%02ld",month,day,hour,minute,second];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.quanmin.tv/json/rooms/%@/info.json?%@",roomId,timeString];
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:urlStr];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//4.分类房间列表
//http://www.quanmin.tv/json/categories/lol/list.json?0913170205
+ (NSURLSessionDataTask *)getQMRoomCateListWithCateName:(NSString *)cateName success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    NSDate *date = [NSDate date];
    NSInteger month = date.ms_month;
    NSInteger day = date.ms_day;
    NSInteger hour = date.ms_hour;
    NSInteger minute = date.ms_minute;
    NSInteger second = date.ms_seconds;
    
    NSString *timeString = [NSString stringWithFormat:@"%02ld%02ld%02ld%02ld%02ld",month,day,hour,minute,second];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.quanmin.tv/json/categories/%@/list.json?%@",cateName,timeString];
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:urlStr];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//5.所有直播房间列表  从0开始加载
//第一页list  http://www.quanmin.tv/json/play/list.json?0913170848
//第二页list2 http://www.quanmin.tv/json/play/list_1.json?0919165930
+ (NSURLSessionDataTask *)getQMAllLiveRoomsPageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    NSDate *date = [NSDate date];
    NSInteger month = date.ms_month;
    NSInteger day = date.ms_day;
    NSInteger hour = date.ms_hour;
    NSInteger minute = date.ms_minute;
    NSInteger second = date.ms_seconds;
    
    NSString *page = @"";
    if (pageNo == 0) {
        page = @"";
    }else {
        page = [NSString stringWithFormat:@"_%ld",pageNo];
    }
    
    NSString *timeString = [NSString stringWithFormat:@"%02ld%02ld%02ld%02ld%02ld",month,day,hour,minute,second];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.quanmin.tv/json/play/list%@.json?%@",page,timeString];
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:urlStr];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 分类列表
 */
+ (NSURLSessionDataTask *)getQMCommonCates:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://www.quanmin.tv/json/categories/list.json?1129173257
    NSDate *date = [NSDate date];
    NSInteger month = date.ms_month;
    NSInteger day = date.ms_day;
    NSInteger hour = date.ms_hour;
    NSInteger minute = date.ms_minute;
    NSInteger second = date.ms_seconds;
    NSString *timeString = [NSString stringWithFormat:@"%02ld%02ld%02ld%02ld%02ld",month,day,hour,minute,second];
    NSString *url = [NSString stringWithFormat:@"http://www.quanmin.tv/json/categories/list.json?%@",timeString];
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:url];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)qm_searchRoomListKeyword:(NSString *)keyword pageNo:(NSInteger)pageNo isLive:(BOOL)isLive success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
//    http://www.quanmin.tv/site/search?197&m=site.search&os=2&p%5BcategoryId%5D=0&p%5Bkey%5D=%E5%B0%8F%E6%99%BA&p%5Bpage%5D=1&p%5Bsize%5D=30&v=2.1.1
    
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"http://www.quanmin.tv/site/search?197"];
    [action setHttpMethod:HttpPost];
    action.params[@"m"] = @"site.search";
    action.params[@"os"] = @"2";
    action.params[@"p[categoryId]"] = @"0";
    action.params[@"p[key]"] = keyword;
    action.params[@"p[page]"] = @(pageNo);
    action.params[@"p[size]"] = @(30);
    action.params[@"v"] = @"2.1.1";

    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
