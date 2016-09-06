//
//  DYRoomModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYRoomModel.h"

@implementation DYRoomModel

- (MSRoomCellModel *)convertToUniteModel {
    
    NSString *iconUrl = self.isVertical ? self.vertical_src : self.room_src;
    return [[MSRoomCellModel alloc]initWithType:(MSLivetypeDouYu) iconUrl:iconUrl title:self.room_name nickName:self.nickname onlineCount:[NSString stringWithFormat:@"%ld",self.online] gameName:self.game_name roomId:self.room_id ownerId:self.owner_uid isVertical:self.isVertical];
}

@end

@implementation DYRoomCateList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"room_list" : [DYRoomModel class]};
}

@end