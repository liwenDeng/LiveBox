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
        view.text = @"标题";
        [view sizeToFit];
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
    _titleLabel.left = 5;
    _titleLabel.width = frame.size.width - 10;
    _titleLabel.bottom = frame.size.height - 15;
    
    _iconView.left = 0;
    _iconView.top = 0;
    _iconView.ms_size = CGSizeMake(frame.size.width, _titleLabel.top - 5);
    
}

- (void)fillWithRoomModel:(id<MSModelAdapterProtocol>)roomModel atIndexPath:(NSIndexPath *)indexPath {
    MSRoomCellModel *model = [roomModel convertToUniteModel];
    self.titleLabel.text = model.title;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
}

+ (CGSize)cellSize {
    return CGSizeMake(kItemWidth, kItemHeight);
}

@end
