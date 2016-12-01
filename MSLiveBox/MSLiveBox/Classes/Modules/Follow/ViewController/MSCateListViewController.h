//
//  MSCateListViewController.h
//  MSLiveBox
//
//  Created by 邓利文 on 2016/11/29.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseViewController.h"

@interface MSCateListViewController : MSBaseViewController

@property (nonatomic, assign, readonly) MSLivetype liveType;

- (instancetype)initWithLiveType:(MSLivetype)type;

@end
