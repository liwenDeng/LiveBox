//
//  MSCommonCateCell.h
//  MSLiveBox
//
//  Created by 邓利文 on 2016/11/29.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kItemWidth ((kSCREEN_WIDTH )  / 3.0)
#define kItemHeight kItemWidth
#define kTitleLabelFont 12.0f

@interface MSCommonCateCell : UICollectionViewCell

- (void)fillWithRoomModel:(id<MSModelAdapterProtocol>)roomModel atIndexPath:(NSIndexPath *)indexPath;

+ (CGSize)cellSize;

@end
