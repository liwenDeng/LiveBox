//
//  MSAllLiveViewController.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/29.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseCollectionVC.h"

@interface MSAllLiveViewController : MSBaseCollectionVC

@property (nonatomic, assign, readonly) MSLivetype liveType;

- (instancetype)initWithLiveType:(MSLivetype)type;

@end
