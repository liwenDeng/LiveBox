//
//  MSBaseBannerModel.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSBaseBannerModel : NSObject 

@property (nonatomic, strong) NSString *roomId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *smallPic; //小图
@property (nonatomic, strong) NSString *bigPic; //大图

@property (nonatomic, assign) MSLivetype type;

- (instancetype)initWithTye:(MSLivetype)type roomId:(NSString *)roomId title:(NSString *)title smallPic:(NSString *)smallPic bigPic:(NSString *)bigPic;


@end
