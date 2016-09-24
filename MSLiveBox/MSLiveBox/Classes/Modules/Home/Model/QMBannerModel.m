//
//  QMBannerModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "QMBannerModel.h"
#import "MSBaseBannerModel.h"

@implementation QMBannerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"room_id": @"id"};
}

- (MSBaseBannerModel *)convertToBannerModel {
    return [[MSBaseBannerModel alloc]initWithTye:(MSLivetypeQuanMin) roomId:self.room_id title:self.title smallPic:self.thumb bigPic:self.thumb];
}

@end



