//
//  QMRoomModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMRoomModel : NSObject <MSModelAdapterProtocol>

@property (nonatomic, copy) NSString *default_image;

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *category_name;

@property (nonatomic, assign) BOOL hidden;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *category_slug;

@property (nonatomic, copy) NSString *beauty_cover;

@property (nonatomic, copy) NSString *recommend_image;

@property (nonatomic, copy) NSString *play_at;

@property (nonatomic, copy) NSString *app_shuffling_image;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *love_cover;

@property (nonatomic, copy) NSString *announcement;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *grade;

@property (nonatomic, copy) NSString *create_at;

@property (nonatomic, copy) NSString *video_quality;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *view;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, copy) NSString *like;

@property (nonatomic, assign) NSInteger screen;

@property (nonatomic, copy) NSString *follow;

@end

@interface QMLinkModel : NSObject

@property (nonatomic, strong) QMRoomModel *link_object;

@end