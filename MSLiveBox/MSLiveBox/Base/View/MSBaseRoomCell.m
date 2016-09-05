//
//  MSBaseRoomCell.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseRoomCell.h"

@implementation MSBaseRoomCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [self updateSubViewsWithFrame:frame];
    }
    return self;
}

- (void)setupSubViews {
    _titleLabel = ({
        UILabel *view = [[UILabel alloc]init];
        view.font = [UIFont systemFontOfSize:kTitleLabelFont];
        [self addSubview:view];
        view;
    });
    
    _iconView = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self.contentView addSubview:view];
        view;
    });
}

- (void)updateSubViewsWithFrame:(CGRect)frame {
    
}

- (void)fillWithRoomModel:(id)roomModel atIndexPath:(NSIndexPath *)indexPath {}

+ (CGSize)cellSize {
    return CGSizeMake(kItemWidth, kItemHeight);
}

@end
