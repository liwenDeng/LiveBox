//
//  MSQMBannerView.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/7.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSQMBannerView.h"

static const CGFloat kCircleRadius = 45.0f;
static const CGFloat kCircleCellHeight = 90.0f;

@interface MSQMCateCell : MSCircleBaseCell

@property (nonatomic, strong) UIImageView *circleImgView;
@property (nonatomic, strong) UILabel *cateLabel;

@end

@implementation MSQMCateCell

- (void)setupSubviews {
    [super setupSubviews];
    _circleImgView = [[UIImageView alloc]init];
    [self.contentView addSubview:_circleImgView];
    [_circleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(kCircleRadius, kCircleRadius));
        make.centerX.equalTo(self);
    }];
    
    _cateLabel = [[UILabel alloc]init];
    [_cateLabel setTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview:_cateLabel];
    [_cateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_circleImgView.mas_bottom).offset(5);
        make.left.equalTo(self);
        make.width.equalTo(self);
    }];
}

@end

@interface MSQMBannerView ()

@property (nonatomic, strong) MSCircleView *cateCircleView;

@end

@implementation MSQMBannerView

- (void)setupSubviews {
    [super setupSubviews];
    
    _cateCircleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kCircleCellHeight) urlImageArray:nil];
    _cateCircleView.backgroundColor = [UIColor whiteColor];
    _cateCircleView.cellClass = [MSQMCateCell class];
    
    [self addSubview:_cateCircleView];
    [_cateCircleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
