//
//  QMRoomModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "QMRoomModel.h"
#import "MSRoomCellModel.h"

@implementation QMRoomModel

- (id)convertToUniteModel {
    return [[MSRoomCellModel alloc]initWithType:(MSLivetypeQuanMin) iconUrl:self.thumb title:self.title nickName:self.nick onlineCount:self.view gameName:self.category_name roomId:self.uid ownerId:self.uid isVertical:0];
}

@end

@implementation QMLinkModel


@end