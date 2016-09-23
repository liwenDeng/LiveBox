//
//  PDRoomModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/23.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSModelAdapterProtocol.h"
#import "MSRoomCellModel.h"

@class PDClassification,PDUserinfo,PDPictures;

@interface PDRoomModel : NSObject <MSModelAdapterProtocol>

@property (nonatomic, copy) NSString *person_num;

@property (nonatomic, copy) NSString *fans;

@property (nonatomic, copy) NSString *roomId;

@property (nonatomic, copy) NSString *reduce_ratio;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *remind_switch;

@property (nonatomic, copy) NSString *rcmd_ratio;

@property (nonatomic, copy) NSString *tag_switch;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *unlock_time;

@property (nonatomic, copy) NSString *person_switch;

@property (nonatomic, strong) PDPictures *pictures;

@property (nonatomic, copy) NSString *classify_switch;

@property (nonatomic, strong) PDClassification *classification;

@property (nonatomic, copy) NSString *stream_status;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *reliable;

@property (nonatomic, copy) NSString *schedule;

@property (nonatomic, copy) NSString *watermark_loc;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *person_src;

@property (nonatomic, strong) PDUserinfo *userinfo;

@property (nonatomic, copy) NSString *speak_interval;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *room_type;

@property (nonatomic, copy) NSString *account_status;

@property (nonatomic, copy) NSString *room_key;

@property (nonatomic, copy) NSString *person_num_thres;

@property (nonatomic, copy) NSString *hostid;

@property (nonatomic, copy) NSString *announcement;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *display_type;

@property (nonatomic, copy) NSString *tag_color;

@property (nonatomic, copy) NSString *rtype_value;

@property (nonatomic, copy) NSString *remind_content;

@property (nonatomic, copy) NSString *watermark_switch;

@property (nonatomic, copy) NSString *ver;

@property (nonatomic, copy) NSString *banned_reason;

@property (nonatomic, copy) NSString *updatetime;

@property (nonatomic, copy) NSString *show_pos;

@property (nonatomic, copy) NSString *rtype_usable;

@end
@interface PDClassification : NSObject

@property (nonatomic, copy) NSString *cname;

@property (nonatomic, copy) NSString *ename;

@end

@interface PDUserinfo : NSObject

@property (nonatomic, assign) NSInteger rid;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSString *avatar;

@end

@interface PDPictures : NSObject

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *qrcode;

@end


#pragma mark - SectionModel

@class PDRoomSectionType;

@interface PDRoomSectionModel : NSObject

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) PDRoomSectionType *type;

@end

@interface PDRoomSectionType : NSObject

@property (nonatomic, copy) NSString *ename;    //hot
@property (nonatomic, copy) NSString *cname;    //热门
@property (nonatomic, copy) NSString *icon;

@end
