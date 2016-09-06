//
//  DYBannerModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYRoomModel.h"
#import "MSBaseBannerModel.h"
#import "MSModelAdapterProtocol.h"

@interface DYBannerModel : NSObject <MSModelAdapterProtocol>

@property (nonatomic, strong) NSString *roomId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic_url; //大图
@property (nonatomic, strong) NSString *tv_pic_url; //小图
@property (nonatomic, strong) DYRoomModel *room;

- (MSBaseBannerModel *)convertToUniteModel;

@end
