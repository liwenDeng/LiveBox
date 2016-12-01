//
//  QMCommonCate.m
//  MSLiveBox
//
//  Created by 邓利文 on 2016/11/29.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "QMCommonCate.h"

@implementation QMCommonCate

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"commonCateId": @"id"};
}

- (MSBaseCateModel *)convertToCateModel {
    return [[MSBaseCateModel alloc]initWithCateId:self.slug title:self.name thumb:self.thumb type:(MSLivetypeQuanMin)];
}

@end
