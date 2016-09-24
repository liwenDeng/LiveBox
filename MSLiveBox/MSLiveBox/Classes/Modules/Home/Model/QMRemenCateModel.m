//
//  QMRemenCateModel.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/9.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "QMRemenCateModel.h"

@implementation QMRemenCateModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"cateId": @"id"};
}

- (MSBaseCateModel *)convertToCateModel {
    return [[MSBaseCateModel alloc]initWithCateId:self.ext.classification title:self.title thumb:self.thumb type:(MSLivetypeQuanMin)];
}

@end

@implementation QMRemenCateExt


@end