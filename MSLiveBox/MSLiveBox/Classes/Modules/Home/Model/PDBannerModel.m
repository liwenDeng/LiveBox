//
//  PDBannerModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/20.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "PDBannerModel.h"
#import "MSBaseBannerModel.h"

@implementation PDBannerModel

- (MSBaseBannerModel *)convertToUniteModel {
    return [[MSBaseBannerModel alloc]initWithTye:(MSLivetypeQuanMin) roomId:self.roomid title:self.title smallPic:self.smallimg bigPic:self.newimg];
}

@end
