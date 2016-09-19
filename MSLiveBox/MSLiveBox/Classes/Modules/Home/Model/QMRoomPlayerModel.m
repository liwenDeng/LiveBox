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
    return @{@"subsource":@"0"};
}

@end

/**
 *  <#Description#>
 */
@implementation QMRoomPlayerSubSource

@end
