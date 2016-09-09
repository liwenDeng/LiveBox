//
//  MSBaseCateModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/9.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseCateModel.h"

@implementation MSBaseCateModel

- (id)initWithCateId:(NSString *)cateId title:(NSString *)title thumb:(NSString *)thumb {
    if (self = [super init]) {
        self.cateId = cateId;
        self.title = title;
        self.thumb = thumb;
    }
    return self;
}

@end
