//
//  MSNetworking+PandaAPI.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/19.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSNetworking+PandaAPI.h"

@implementation MSNetworking (PandaAPI)


//1.
+ (NSURLSessionDataTask *)getPandaBannersWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://api.m.panda.tv/ajax_rmd_ads_get?__version=1.1.7.1305&__plat=ios&__channel=appstore
    NSString *urlStr = @"http://api.m.panda.tv/ajax_rmd_ads_get?__version=1.1.7.1305&__plat=ios&__channel=appstore";
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:urlStr];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//2.
+ (NSURLSessionDataTask *)getPandaHomeRoomListWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://api.m.panda.tv/ajax_get_live_list_by_multicate?pagenum=4&hotroom=1&__version=1.1.7.1305&__plat=ios&__channel=appstore
    NSString *urlStr = @"http://api.m.panda.tv/ajax_get_live_list_by_multicate?pagenum=4&hotroom=1&__version=1.1.7.1305&__plat=ios&__channel=appstore";
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:urlStr];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//3.
+ (NSURLSessionDataTask *)getPandaRoomPlayerInfoWithRoomId:(NSString *)roomId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //@"http://api.m.panda.tv/ajax_get_liveroom_baseinfo?roomid=452530&slaveflag=1&__version=1.1.7.1305&__plat=ios&__channel=appstore"
    NSString *urlStr = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_liveroom_baseinfo?roomid=%@&slaveflag=1&__version=1.1.7.1305&__plat=ios&__channel=appstore",roomId];
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:urlStr];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//4.
+ (NSURLSessionDataTask *)getPandaAllLiveListWithPageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://api.m.panda.tv/ajax_live_lists?pageno=2&pagenum=10&order=person_num&status=2&__version=1.1.7.1305&__plat=ios&__channel=appstore
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_live_lists?pageno=%ld&pagenum=20&order=person_num&status=2&__version=1.1.7.1305&__plat=ios&__channel=appstore",pageNo];
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:urlStr];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getPandaAllLiveListWithCateId:(NSString*)cateId pageNo:(NSInteger)pageNo success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=lol&pageno=2&pagenum=10&order=person_num&status=2&__version=1.1.7.1305&__plat=ios&__channel=appstore
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.m.panda.tv/ajax_get_live_list_by_cate?cate=%@&pageno=%ld&pagenum=10&order=person_num&status=2&__version=1.1.7.1305&__plat=ios&__channel=appstore",cateId,pageNo];
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:urlStr];
    [action setHttpMethod:httpGet];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
