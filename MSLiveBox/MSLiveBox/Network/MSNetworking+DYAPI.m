//
//  MSNetworking+DYAPI.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSNetworking+DYAPI.h"
#import "NSString+Code.h"

@implementation MSNetworking (DYAPI)

//1.
+ (NSURLSessionDataTask *)getDouyuBigDataInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://capi.douyucdn.cn/api/v1/getbigDataRoom?aid=android1&client_sys=android&time=1468074120&token=5082405_b1c24e33bf3db5b4&auth=8885837426ded0275f826f300dbd6487
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"https://capi.douyucdn.cn/api/v1/getbigDataRoom"];
    action.params[@"aid"] = @"android1";
    action.params[@"client_sys"] = @"android";
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    action.params[@"time"] = [NSString stringWithFormat:@"%f",time];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//2.
+ (NSURLSessionDataTask *)getDouyuFaceInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://capi.douyucdn.cn/api/v1/getVerticalRoom?aid=android1&client_sys=android&limit=4&offset=0&time=1468074120&auth=461dc91817f22ef364459445078c38e5
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"https://capi.douyucdn.cn/api/v1/getVerticalRoom"];
    
    action.params[@"aid"] = @"android1";
    action.params[@"client_sys"] = @"android";
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    action.params[@"time"] = [NSString stringWithFormat:@"%f",time];
    action.params[@"limit"] = @"4";
    action.params[@"offset"]= @"0";
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//3.
+ (NSURLSessionDataTask *)getDouyuHotCateListInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://capi.douyucdn.cn/api/v1/getHotCate?aid=android1&client_sys=android&time=1470127800&token=&auth=106ce60e97ada8b26345b7c7d742f8eb
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"https://capi.douyucdn.cn/api/v1/getHotCate"];
    action.params[@"aid"] = @"android1";
    action.params[@"client_sys"] = @"android";
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    action.params[@"time"] = [NSString stringWithFormat:@"%f",time];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 4.获取分类房间列表
+ (NSURLSessionDataTask *)getDouyuLiveCateId:(NSInteger)cateId limit:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://capi.douyucdn.cn/api/v1/live/1?limit=20&client_sys=ios&offset=0
    NSString *url = [NSString stringWithFormat:@"https://capi.douyucdn.cn/api/v1/live/%ld",(long)cateId];
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:url];
    action.params[@"limit"] = @(limit);
    action.params[@"offset"] = @(offset);
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 5.获取颜值类房间列表
+ (NSURLSessionDataTask *)getFaceRoomListLimit:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=20&client_sys=ios&offset=0
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"https://capi.douyucdn.cn/api/v1/getVerticalRoom"];
    action.params[@"limit"] = @(limit);
    action.params[@"offset"] = @(offset);
    action.params[@"client_sys"] = @"ios";
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//6.
+ (NSURLSessionDataTask *)getDouyuSlideBanners:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://capi.douyucdn.cn/api/v1/slide/6?version=2.291&client_sys=ios
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"https://capi.douyucdn.cn/api/v1/slide/6?version=2.291&client_sys=ios"];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 所有直播
+ (NSURLSessionDataTask *)getAllDouyuLiveLimit:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure{
    
    //http://capi.douyucdn.cn/api/v1/getColumnRoom/9?limit=20&client_sys=ios&offset=0
    //http://capi.douyucdn.cn/api/v1/getColumnRoom/9?limit=20&client_sys=ios&offset=20
    
    //http://capi.douyucdn.cn/api/v1/live?limit=20&client_sys=ios&offset=0
//    NSString *urlStr = [NSString stringWithFormat:@"https://capi.douyucdn.cn/api/v1/getColumnRoom/9?limit=%ld&client_sys=ios&offset=%ld",limit,offset];
    NSString *urlStr = [NSString stringWithFormat:@"http://capi.douyucdn.cn/api/v1/live?limit=%ld&client_sys=ios&offset=%ld",limit,offset];
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:urlStr];

    //可选属性
    //    action.showLog = YES;
    //    action.actionWillInvokeBlock = ^{
    //        NSLog(@"will start");
    //    };
    //
    //    action.actionDidInvokeBlock = ^(BOOL isSuccess) {
    //        if (isSuccess) {
    //            NSLog(@"success");
    //        }
    //        else {
    //            NSLog(@"failure");
    //        }
    //    };
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 搜索
+ (NSURLSessionDataTask *)getDouyuRoomListWithKeyword:(NSString *)keyword limit:(NSInteger)limit offset:(NSInteger)offset success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://capi.douyucdn.cn/api/v1/searchNew/%E5%BE%AE%E7%AC%91/1?limit=20&client_sys=ios&offset=0 搜：微笑
    NSString *urlStr = [NSString stringWithFormat:@"https://capi.douyucdn.cn/api/v1/searchNew/%@/1?limit=%ld&client_sys=ios&offset=%ld",[keyword ms_urlEncode] ,limit,offset];
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:urlStr];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getDouyuRoomListRoomId:(NSString *)roomId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://capi.douyucdn.cn/api/v1/room/2333?aid=ios&client_sys=ios&ne=1&support_pwd=1&time=1475206140&auth=39cb6cd5e383ff9f976b7d32acb1ec6b 2333
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    NSString *urlStr = [NSString stringWithFormat:@"https://capi.douyucdn.cn/api/v1/room/%@?aid=ios&client_sys=ios&ne=1&support_pwd=1&time=%f",roomId,time];
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:urlStr];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 分类
//http://capi.douyucdn.cn/api/v1/getColumnDetail?client_sys=ios 分类列表
+ (NSURLSessionDataTask *)getDouyuCommonCates:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"http://capi.douyucdn.cn/api/v1/getColumnDetail?client_sys=ios"];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
