//
//  QMRoomPlayerModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/13.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "QMRoomPlayerModel.h"

/**
 *  <#Description#>
 */
@implementation QMRoomPlayerModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"room_lines":[QMRoomPlayerLineModel class]};
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
