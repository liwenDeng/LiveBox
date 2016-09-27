//
//  QMBannerModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSModelAdapterProtocol.h"
#import "QMRoomModel.h"

@interface QMBannerModel : NSObject <MSModelAdapterProtocol>

@property (nonatomic, copy) NSString *room_id;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) NSInteger slot_id;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *create_at;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *fk;

@property (nonatomic, strong) QMRoomModel *link_object;

@end


