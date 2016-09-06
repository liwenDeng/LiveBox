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

@end
