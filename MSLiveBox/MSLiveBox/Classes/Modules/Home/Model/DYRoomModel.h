//
//  DYRoomModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSModelAdapterProtocol.h"
#import "MSRoomCellModel.h"

@interface DYRoomModel : NSObject <MSModelAdapterProtocol>

@property (nonatomic, copy) NSString *room_id;
@property (nonatomic, copy) NSString *room_name;
@property (nonatomic, copy) NSString *nickname;     //主播昵称
@property (nonatomic, copy) NSString *owner_uid;    //主播id
@property (nonatomic, copy) NSString *room_src;     //房间图片
@property (nonatomic, copy) NSString *vertical_src; //房间图片
@property (nonatomic, assign) NSInteger online;     //在线人数
@property (nonatomic, copy) NSString *game_name;    //游戏名称

// 以下为不重要信息
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *child_id;
@property (nonatomic, copy) NSString *show_time;
@property (nonatomic, copy) NSString *show_status;
@property (nonatomic, copy) NSString *specific_catalog;
@property (nonatomic, assign) NSInteger ranktype;
@property (nonatomic, assign) NSInteger isVertical; //是否需要垂直全屏显示
@property (nonatomic, copy) NSString *cate_id;
@property (nonatomic, copy) NSString *specific_status;
@property (nonatomic, copy) NSString *vod_quality;

@end

/**
 *  斗鱼热门分类列表
 */
@interface DYRoomCateList : NSObject <MSModelAdapterProtocol>

@property (nonatomic, strong) NSArray *room_list;
@property (nonatomic, copy) NSString *tag_name;
@property (nonatomic, assign) NSInteger tag_id;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *push_vertical_screen;

@end
