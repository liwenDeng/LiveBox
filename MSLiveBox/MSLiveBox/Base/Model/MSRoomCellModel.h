//
//  MSRoomModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSRoomCellModel : NSObject

@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *nickName;//主播昵称
@property (nonatomic, copy) NSString *onlieCount;//在线人数
@property (nonatomic, copy) NSString *gameName; //游戏名称
@property (nonatomic, copy) NSString *roomId;   //房间id
@property (nonatomic, copy) NSString *ownerId; //主播id

@property (nonatomic, assign) NSInteger isVertical;//是否需要竖直显示
@property (nonatomic, assign) MSLivetype type;  //直播平台

- (instancetype)initWithType:(MSLivetype)type iconUrl:(NSString*)iconUrl title:(NSString *)title nickName:(NSString *)nickName onlineCount:(NSString *)onlineCount gameName:(NSString *)gameName roomId:(NSString *)roomId ownerId:(NSString *)ownerId isVertical:(NSInteger)isVertical;

@end
