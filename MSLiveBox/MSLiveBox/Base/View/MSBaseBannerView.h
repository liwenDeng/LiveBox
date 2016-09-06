//
//  MSBaseBannerView.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSBaseBannerView;

@protocol MSBaseBannerViewDelegate <NSObject>

- (void)banner:(MSBaseBannerView*)banner clickedAtIndex:(NSInteger)index roomId:(NSString *)roomId;

@end

@interface MSBaseBannerView : UICollectionReusableView

@property (nonatomic, weak) id<MSBaseBannerViewDelegate> delegate;

- (void)fillWithBannerModels:(NSArray *)bannerModels;

+ (CGSize)sectionHeaderViewSize;

@end
