//
//  MSBaseCateModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/9.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSBaseCateModel : NSObject

@property (nonatomic, strong) NSString *cateId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *subtitle;

- initWithCateId:(NSString *)cateId title:(NSString *)title thumb:(NSString *)thumb;

@end
