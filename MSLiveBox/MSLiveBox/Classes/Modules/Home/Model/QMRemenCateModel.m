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

- (id)convertToUniteModel {
    return [[MSBaseCateModel alloc]initWithCateId:self.cateId title:self.title thumb:self.thumb];
}

@end
