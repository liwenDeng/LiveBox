//
//  MSModelAdapterProtocol.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSRoomCellModel.h" //cell Item
#import "MSBaseBannerModel.h" //banner
#import "MSBaseCateModel.h" //cate
#import "MSBasePlayerInfoModel.h" //roomInfo

@protocol MSModelAdapterProtocol <NSObject>

@optional

//- (id)convertToUniteModel;

/**
 *  转为cell Model
 */
- (MSRoomCellModel *)convertToCellModel;

/**
 *  转为轮播 Model
 */
- (MSBaseBannerModel *)convertToBannerModel;

/**
 *  转为分类(sectionHeader) Model
 */
- (MSBaseCateModel *)convertToCateModel;

/**
 *  转为房间信息 Model
 */
- (MSBasePlayerInfoModel *)convertToPlayerInfoModel;

/**
 *  播放地址
 */
@property (nonatomic, copy, readonly)NSString *videoUrl;

@end
