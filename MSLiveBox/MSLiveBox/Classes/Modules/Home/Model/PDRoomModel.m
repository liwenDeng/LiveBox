//
//  PDRoomModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/23.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "PDRoomModel.h"
#import "MSBaseCateModel.h"

@implementation PDRoomModel

- (MSRoomCellModel *)convertToCellModel {
    return [[MSRoomCellModel alloc]initWithType:(MSLivetypePanda) iconUrl:self.pictures.img title:self.name nickName:self.userinfo.nickName onlineCount:[NSString stringWithFormat:@"%@",self.person_num] gameName:self.classification.cname roomId:self.roomId ownerId:self.hostid isVertical:0];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"roomId" : @"id"};
}

@end

@implementation PDClassification

@end


@implementation PDUserinfo

@end


@implementation PDPictures

@end

#pragma mark - SectionModel

@implementation PDRoomSectionModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items" : [PDRoomModel class]};
}

- (MSBaseCateModel *)convertToCateModel {
    return [[MSBaseCateModel alloc]initWithCateId:self.type.ename title:self.type.cname thumb:self.type.icon type:(MSLivetypePanda)];
}

@end

@implementation PDRoomSectionType

- (MSBaseCateModel *)convertToCateModel {
    return [[MSBaseCateModel alloc]initWithCateId:self.ename title:self.cname thumb:self.img type:(MSLivetypePanda)];
}

@end
