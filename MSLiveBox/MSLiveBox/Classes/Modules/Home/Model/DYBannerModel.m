//
//  DYBannerModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYBannerModel.h"

@implementation DYBannerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"roomId" : @"id"};
}

- (MSBaseBannerModel *)convertToBannerModel {
    MSBaseBannerModel *banner = [[MSBaseBannerModel alloc]initWithTye:(MSLivetypeDouYu) roomId:self.roomId title:self.title smallPic:self.tv_pic_url bigPic:self.pic_url];
    return banner;
}

- (MSRoomCellModel *)convertToCellModel {
    return [self.room convertToCellModel];
}
//- (MSBaseCateModel *)convertToCateModel {
//    return [[MSBaseCateModel alloc]initWithCateId:self.roomId title:self.title thumb:self.tv_pic_url type:(MSLivetypeDouYu)];
//}

@end
