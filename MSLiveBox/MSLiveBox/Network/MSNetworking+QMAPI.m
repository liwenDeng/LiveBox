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

//5.所有直播房间列表
//http://www.quanmin.tv/json/play/list.json?0913170848
+ (NSURLSessionDataTask *)getQMAllLiveRooms:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    NSDate *date = [NSDate date];
    NSInteger month = date.ms_month;
    NSInteger day = date.ms_day;
    NSInteger hour = date.ms_hour;
    NSInteger minute = date.ms_minute;
    NSInteger second = date.ms_seconds;
    
    NSString *timeString = [NSString stringWithFormat:@"%02ld%02ld%02ld%02ld%02ld",month,day,hour,minute,second];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.quanmin.tv/json/play/list.json?%@",timeString];
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:urlStr];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
