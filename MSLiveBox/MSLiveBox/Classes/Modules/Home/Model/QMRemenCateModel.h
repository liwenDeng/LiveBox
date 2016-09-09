//
//  QMRemenCateModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/9.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSBaseCateModel.h"

/**
 *  圆圈 分类轮播图
 */
@interface QMRemenCateModel : NSObject <MSModelAdapterProtocol>

@property (nonatomic, strong) NSString *cateId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *slot_id;

@end
