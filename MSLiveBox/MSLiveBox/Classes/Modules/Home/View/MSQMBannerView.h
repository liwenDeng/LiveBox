//
//  MSQMBannerView.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/7.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseBannerView.h"

@class MSQMBannerView;

@protocol MSQMBannerViewDelegate <NSObject>

- (void)bannerView:(MSQMBannerView *)bannerView clickedCateCircleAtIndex:(NSInteger)index cateId:(NSString *)cateId;

@end

@interface MSQMBannerView : MSBaseBannerView

@property (nonatomic, weak)id<MSQMBannerViewDelegate> cateDelegate;

- (void)fillWithBannerModels:(NSArray *)bannerModels cateModels:(NSArray *)cateModels;

@end
