//
//  MSBaseBannerView.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCircleView.h"
#import "MSBaseBannerModel.h"

static const CGFloat kBannerHeight = 140;
static const CGFloat kPageControlHeight = 30;

@class MSBaseBannerView;

@protocol MSBaseBannerViewDelegate <NSObject>

- (void)banner:(MSBaseBannerView*)banner clickedAtIndex:(NSInteger)index roomId:(NSString *)roomId;

@end

@interface MSBaseBannerView : UICollectionReusableView

@property (nonatomic, strong) MSCircleView *circleView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, weak) id<MSBaseBannerViewDelegate> delegate;

- (void)setupSubviewsFrame:(CGRect)frame;

- (void)updateFrame:(CGRect)frame;

- (void)fillWithBannerModels:(NSArray *)bannerModels;

+ (CGSize)sectionHeaderViewSize;

@end

@interface MSBannerCell : MSCircleBaseCell

@end