//
//  QMCommonCate.h
//  MSLiveBox
//
//  Created by 邓利文 on 2016/11/29.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMCommonCate : NSObject <MSModelAdapterProtocol>

@property (nonatomic, copy) NSString *commonCateId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *slug;
@property (nonatomic, copy) NSString *first_letter;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *prompt;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *priority;
@property (nonatomic, copy) NSString *screen;

@end
