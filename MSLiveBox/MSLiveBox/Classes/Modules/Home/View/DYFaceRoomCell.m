//
//  DYFaceRoomCell.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYFaceRoomCell.h"

#define kCityLabelFont 12.0f

@interface DYFaceRoomCell ()

@property (nonatomic, strong) UILabel* cityLabel;

@end

@implementation DYFaceRoomCell

- (void)setupSubViews {
    [super setupSubViews];
    
    self.cityLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:kCityLabelFont];
        [label setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:label];
        label.text = @"成都市";
        [label sizeToFit];
        label;
    });
}

- (void)updateSubViewsWithFrame:(CGRect)frame {
    [super updateSubViewsWithFrame:frame];
    self.iconView.ms_size = CGSizeMake(kItemWidth, kItemWidth);
    
    self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.titleLabel.top = self.iconView.bottom + 10;
    
    self.cityLabel.top = self.titleLabel.bottom + 5;
    self.cityLabel.left = 10;
    self.cityLabel.width = frame.size.width - 10;
}


- (void)fillWithRoomModel:(id<MSModelAdapterProtocol>)roomModel atIndexPath:(NSIndexPath *)indexPath {
    MSRoomCellModel *model = [roomModel convertToCellModel];
    self.titleLabel.text = model.nickName;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
}

+ (CGSize)cellSize {
    return CGSizeMake(kItemWidth, kItemWidth + 35 + 14.0f + kCityLabelFont);
}

@end
