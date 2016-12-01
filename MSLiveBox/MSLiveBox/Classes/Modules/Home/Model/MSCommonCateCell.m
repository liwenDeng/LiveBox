//
//  MSCommonCateCell.m
//  MSLiveBox
//
//  Created by 邓利文 on 2016/11/29.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSCommonCateCell.h"
#import "UIImageView+CornerRadius.h"

@interface MSCommonCateCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation MSCommonCateCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [self updateSubViewsWithFrame:frame];
    }
    return self;
}

- (void)setupSubViews {
    
    _iconView = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(kItemWidth*0.4, kItemWidth*0.4));
        }];
        [view zy_cornerRadiusRoundingRect];
        view;
    });
    
    _nameLabel = ({
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        [label setTextAlignment:(NSTextAlignmentCenter)];
        label.font = [UIFont systemFontOfSize:kTitleLabelFont];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_iconView);
            make.top.equalTo(_iconView.mas_bottom).offset(10);
            make.width.mas_equalTo(kItemWidth);
        }];
        
        label;
    });
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.borderColor = [UIColor ms_colorWithHexString:@"#efefef"].CGColor;
    self.contentView.layer.borderWidth = 0.5;
}

- (void)updateSubViewsWithFrame:(CGRect)frame {

}

- (void)fillWithRoomModel:(id<MSModelAdapterProtocol>)roomModel atIndexPath:(NSIndexPath *)indexPath {
    MSBaseCateModel *cateModel = [roomModel convertToCateModel];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:cateModel.thumb]];
    self.nameLabel.text = cateModel.title;
}

+ (CGSize)cellSize {
    return CGSizeMake(kItemWidth, kItemHeight);
}

@end
