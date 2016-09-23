//
//  QMRoomPlayerModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/13.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QMRoomPlayerLineModel,QMRoomPlayerLiveModel,QMRoomPlayerSource,QMRoomPlayerSubSource;

@interface QMRoomPlayerModel : NSObject

@property (nonatomic, strong) NSString *uid; //userid
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *avatar; //头像
//@property (nonatomic, strong) NSString *slug;
//@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *category_id; //13
@property (nonatomic, strong) NSString *category_name; //全民户外
@property (nonatomic, strong) NSString *screen;     //0
@property (nonatomic, strong) NSString *view;       //观看人数
@property (nonatomic, strong) NSString *weight;     //经验
@property (nonatomic, strong) NSString *follow;     //关注人数
@property (nonatomic, strong) NSString *last_play_at;   //上次播放时间
@property (nonatomic, assign) BOOL play_status;    //播放状态
//@property (nonatomic, assign) BOOL forbid_status;
//@property (nonatomic, assign) BOOL police_forbid;

@property (nonatomic, strong)QMRoomPlayerLiveModel *live;
@property (nonatomic, strong)NSArray *room_lines;

@property (nonatomic, strong) NSString *is_star; //是否关注
@property (nonatomic, strong) NSString *play_at; //开播时间
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *video;

@end

@interface QMRoomPlayerLiveModel : NSObject

@property (nonatomic, strong) QMRoomPlayerLineModel* ws;

@end

/**
 *  线路
 */
@interface QMRoomPlayerLineModel : NSObject

@property (nonatomic, strong) NSString *name; //ws bd tx ali
@property (nonatomic, strong) NSString *def_pc;
@property (nonatomic, strong) NSString *def_mobile;
@property (nonatomic, strong) QMRoomPlayerSource *hls;
@property (nonatomic, strong) QMRoomPlayerSource *flv;

@end

@interface QMRoomPlayerSource : NSObject

@property (nonatomic, strong) QMRoomPlayerSubSource* subsource0;
@property (nonatomic, strong) QMRoomPlayerSubSource* subsource1;
@property (nonatomic, strong) QMRoomPlayerSubSource* subsource2;
@property (nonatomic, strong) QMRoomPlayerSubSource* subsource3;
@property (nonatomic, strong) QMRoomPlayerSubSource* subsource4;
@property (nonatomic, strong) QMRoomPlayerSubSource* subsource5;

@property (nonatomic, strong) NSString *main_pc;
@property (nonatomic, strong) NSString *main_mobile;

@end

@interface QMRoomPlayerSubSource : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *src;

@end