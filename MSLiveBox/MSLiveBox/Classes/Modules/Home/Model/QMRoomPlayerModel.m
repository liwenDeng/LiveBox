//
//  QMRoomPlayerModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/13.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "QMRoomPlayerModel.h"
#import "MSRoomCellModel.h"
/**
 *  <#Description#>
 */
@implementation QMRoomPlayerModel

- (MSRoomCellModel *)convertToCellModel {
    return [[MSRoomCellModel alloc]initWithType:(MSLivetypeQuanMin) iconUrl:self.thumb title:self.title nickName:self.nick onlineCount:self.view gameName:self.category_name roomId:self.uid ownerId:self.uid isVertical:NO];
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"room_lines":[QMRoomPlayerLineModel class]};
}

- (NSString *)videoUrl {
    NSString* sourceNum = self.live.ws.flv.main_mobile;
//    self.live.ws.flv.subsource0
    NSString* sourceName = [NSString stringWithFormat:@"subsource%@",sourceNum];
    QMRoomPlayerSubSource* source = [self.live.ws.flv valueForKey:sourceName];
    return source.src;
}

@end

/**
 *  <#Description#>
 */
@implementation QMRoomPlayerLiveModel

@end

/**
 *  <#Description#>
 */
@implementation QMRoomPlayerLineModel


@end

/**
 *  <#Description#>
 */
@implementation QMRoomPlayerSource

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"subsource0":@"0",
             @"subsource1":@"1",
             @"subsource2":@"2",
             @"subsource3":@"3",
             @"subsource4":@"4",
             @"subsource5":@"5"};
}

@end

/**
 *  <#Description#>
 */
@implementation QMRoomPlayerSubSource

@end
