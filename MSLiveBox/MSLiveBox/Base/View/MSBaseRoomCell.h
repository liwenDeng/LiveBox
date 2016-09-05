//
//  MSBaseRoomCell.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kItemWidth (kSCREEN_WIDTH - 30 ) / 2.0
#define kItemHeight (kItemWidth * 7.0 / 9.0)
#define kTitleLabelFont 12.0f

@interface MSBaseRoomCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)setupSubViews;
- (void)updateSubViewsWithFrame:(CGRect)frame;
- (void)fillWithRoomModel:(id)roomModel atIndexPath:(NSIndexPath *)indexPath;

+ (CGSize)cellSize;

@end
