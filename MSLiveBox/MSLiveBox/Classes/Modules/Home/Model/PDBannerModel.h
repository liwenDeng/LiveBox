//
//  PDBannerModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/20.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSModelAdapterProtocol.h"

@interface PDBannerModel : NSObject <MSModelAdapterProtocol>

@property (nonatomic, copy) NSString *roomid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *room_key; //key 用来生成播放地址
@property (nonatomic, copy) NSString *bigimg;   //大图
@property (nonatomic, copy) NSString *smallimg; //小图
@property (nonatomic, copy) NSString *nickname; //主播名称
@property (nonatomic, copy) NSString *url;      //网页版地址 "http://www.panda.tv/room/485118"
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *name;     //和title标题相同
@property (nonatomic, copy) NSString *person_num;   //观看人数

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *roomurl;

@property (nonatomic, copy) NSString *qcmsstr3;

@property (nonatomic, copy) NSString *newimg;

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSString *brief;

@property (nonatomic, copy) NSString *qcmsint3;

@property (nonatomic, copy) NSString *schedule;

@property (nonatomic, copy) NSString *stream_status;

@property (nonatomic, copy) NSString *qcmsstr4;

@property (nonatomic, copy) NSString *details;

@property (nonatomic, copy) NSString *display_type;

@property (nonatomic, copy) NSString *qcmsint4;

@property (nonatomic, copy) NSString *notice;

@property (nonatomic, copy) NSString *qcmsstr5;

@property (nonatomic, copy) NSString *qcmsint1;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *classification;

@property (nonatomic, copy) NSString *qcmsint5;

@property (nonatomic, copy) NSString *order;

@property (nonatomic, copy) NSString *end_time;

@end
