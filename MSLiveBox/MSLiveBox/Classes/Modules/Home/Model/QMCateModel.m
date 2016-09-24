//
//  QMCateModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "QMCateModel.h"
#import "MSBaseCateModel.h"

@implementation QMCateModel

- (MSBaseCateModel *)convertToCateModel {
    return [[MSBaseCateModel alloc]initWithCateId:self.category_slug title:self.name thumb:nil type:(MSLivetypeQuanMin)];
}

@end
