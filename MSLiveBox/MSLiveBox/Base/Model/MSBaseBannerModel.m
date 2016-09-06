//
//  MSBaseBannerModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseBannerModel.h"

@implementation MSBaseBannerModel

- (instancetype)initWithTye:(MSLivetype)type roomId:(NSString *)roomId title:(NSString *)title smallPic:(NSString *)smallPic bigPic:(NSString *)bigPic {
    if (self = [super init]) {
        self.type = type;
        self.roomId = roomId;
        self.title = title;
        self.smallPic = smallPic;
        self.bigPic = bigPic;
    }
    return self;
}

@end
