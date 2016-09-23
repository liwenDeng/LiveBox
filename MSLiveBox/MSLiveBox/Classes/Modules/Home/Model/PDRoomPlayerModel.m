//
//  PDRoomPlayerModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/23.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "PDRoomPlayerModel.h"

@implementation PDRoomPlayerModel

/**
 *  计算加密后的播放地址
 */
- (NSString *)playerUrl {
//     http://pl{}.live.panda.tv/live_panda/{}.flv'.format(plflag[1],room_key
    
    NSArray * pflag = [self.videoinfo.plflag componentsSeparatedByString:@"_"];
    NSString *real_url = [NSString stringWithFormat:@"http://pl%@.live.panda.tv/live_panda/%@.flv",pflag[1],self.videoinfo.room_key];
    return real_url;
}

@end

@implementation PDRoominfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"roomId" : @"id"};
}

@end

@implementation PDHostinfo

@end


@implementation PDVideoinfo

@end


@implementation PDStream_Addr

@end


