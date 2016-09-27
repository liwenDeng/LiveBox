//
//  PDBannerModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/20.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "PDBannerModel.h"
#import "MSBaseBannerModel.h"

@implementation PDBannerModel

- (MSBaseBannerModel *)convertToBannerModel {
    return [[MSBaseBannerModel alloc]initWithTye:(MSLivetypePanda) roomId:self.roomid title:self.title smallPic:self.smallimg bigPic:self.newimg];
}

- (MSRoomCellModel *)convertToCellModel {
    return [[MSRoomCellModel alloc]initWithType:(MSLivetypePanda) iconUrl:self.smallimg title:self.title nickName:self.nickname onlineCount:self.person_num gameName:nil roomId:self.roomid ownerId:self.roomid isVertical:0];
}

@end
