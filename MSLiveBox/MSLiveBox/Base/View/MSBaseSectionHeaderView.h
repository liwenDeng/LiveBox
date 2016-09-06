//
//  MSBaseSectionHeaderView.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSBaseSectionHeaderView;
@protocol MSBaseSectionHeaderViewDelegate <NSObject>

- (void)sectionHeaderView:(MSBaseSectionHeaderView *)sectionHeaderView clickedMoreButtonAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MSBaseSectionHeaderView : UICollectionReusableView

@property (nonatomic, weak) id<MSBaseSectionHeaderViewDelegate> delegate;

- (void)fillWithTagName:(NSString *)tagName atIndexPath:(NSIndexPath *)indexPath;

+ (CGSize)sectionHeaderViewSize;

@end
