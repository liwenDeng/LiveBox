//
//  QMCateModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMCateModel : NSObject

@property (nonatomic, copy) NSString *slug;//根据这个来取对应的roomList

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *category_slug;

@end
