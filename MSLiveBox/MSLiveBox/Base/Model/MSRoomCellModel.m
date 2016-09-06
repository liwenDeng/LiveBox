//
//  MSRoomModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSRoomCellModel.h"

@implementation MSRoomCellModel

- (instancetype)initWithType:(MSLivetype)type iconUrl:(NSString *)iconUrl title:(NSString *)title nickName:(NSString *)nickName onlineCount:(NSString *)onlineCount gameName:(NSString *)gameName roomId:(NSString *)roomId ownerId:(NSString *)ownerId isVertical:(NSInteger)isVertical {
    if (self = [super init]) {
        self.type = type;
        self.title = title;
        self.nickName = nickName;
        self.onlieCount = onlineCount;
        self.gameName = gameName;
        self.roomId = roomId;
        self.ownerId = ownerId;
        self.isVertical = isVertical;
        self.iconUrl = iconUrl;
    }
    return self;
}

@end
