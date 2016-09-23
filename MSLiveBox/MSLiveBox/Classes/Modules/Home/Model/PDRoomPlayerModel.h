//
//  PDRoomPlayerModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/23.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDRoomModel.h"

@class PDRoominfo,PDHostinfo,PDVideoinfo,PDStream_Addr;

@interface PDRoomPlayerModel : NSObject

@property (nonatomic, strong) PDRoominfo *roominfo;

@property (nonatomic, strong) PDHostinfo *hostinfo;

@property (nonatomic, strong) PDVideoinfo *videoinfo;

@property (nonatomic, strong) PDUserinfo *userinfo;

@property (nonatomic, copy, readonly) NSString *playerUrl;

@end
@interface PDRoominfo : NSObject

@property (nonatomic, copy) NSString *roomId;

@property (nonatomic, copy) NSString *classification;

@property (nonatomic, copy) NSString *person_num;

@property (nonatomic, copy) NSString *remind_status;

@property (nonatomic, copy) NSString *cate;

@property (nonatomic, copy) NSString *display_type;

@property (nonatomic, copy) NSString *details;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) PDPictures *pictures;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *remind_content;

@property (nonatomic, copy) NSString *room_type;

@property (nonatomic, copy) NSString *remind_time;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *fans;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *bulletin;

@end

//@interface PDPictures : NSObject
//
//@property (nonatomic, copy) NSString *img;
//
//@end

@interface PDHostinfo : NSObject

@property (nonatomic, assign) NSInteger rid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *bamboos;

@property (nonatomic, copy) NSString *avatar;

@end

@interface PDVideoinfo : NSObject

@property (nonatomic, strong) PDStream_Addr *stream_addr;

@property (nonatomic, copy) NSString *room_key;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *plflag;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *ts;

@property (nonatomic, copy) NSString *watermark;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<NSString *> *slaveflag;

@end

@interface PDStream_Addr : NSObject

@property (nonatomic, copy) NSString *OD;

@property (nonatomic, copy) NSString *SD;

@property (nonatomic, copy) NSString *HD;

@end

//@interface PDUserinfo : NSObject
//
//@property (nonatomic, assign) NSInteger rid;
//
//@end

