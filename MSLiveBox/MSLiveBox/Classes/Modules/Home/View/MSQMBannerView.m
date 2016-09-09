//
//  MSQMBannerView.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/7.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSQMBannerView.h"
#import "MSBaseCateModel.h"

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
    
    _cateCircleView.frame = CGRectMake(0, 0, kBannerHeight, kSCREEN_WIDTH);
    
    _cateCircleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kCircleCellHeight) urlImageArray:nil perPageCount:5];
    _cateCircleView.backgroundColor = [UIColor whiteColor];
    _cateCircleView.cellClass = [MSQMCateCell class];
    
    [self addSubview:_cateCircleView];
    _cateCircleView.frame = CGRectMake(0, kBannerHeight, kSCREEN_WIDTH, kCircleCellHeight);
    
}

- (void)fillWithBannerModels:(NSArray *)bannerModels cateModels:(NSArray *)cateModels {
    [super fillWithBannerModels:bannerModels];
    
    NSMutableArray *urls = [NSMutableArray array];
    for (id<MSModelAdapterProtocol> cateModel in cateModels) {
         MSBaseCateModel *model = [cateModel convertToUniteModel];
        [urls addObject:model.thumb];
    }
    self.cateCircleView.imageArray = urls;
    
    [self.cateCircleView configCustomCell:^(MSCircleBaseCell *customCell, NSInteger index) {
        MSQMCateCell *cell = (MSQMCateCell *)customCell;
        MSBaseCateModel *cateModel = cateModels[index];
        cell.cateLabel.text = cateModel.title;
    }];
    
    __weak typeof (self)weakSelf = self;
    [self.cateCircleView addTapBlock:^(NSInteger index) {
        if ([weakSelf.cateDelegate respondsToSelector:@selector(banner:clickedAtIndex:roomId:)]) {
            MSBaseCateModel *cateModel = cateModels[index];
            [self.cateDelegate bannerView:self clickedCateCircleAtIndex:index cateId:cateModel.cateId];
        }
    }];

}

+ (CGSize)sectionHeaderViewSize {
    return CGSizeMake(kSCREEN_WIDTH, kBannerHeight + kCircleCellHeight);
}
@end
