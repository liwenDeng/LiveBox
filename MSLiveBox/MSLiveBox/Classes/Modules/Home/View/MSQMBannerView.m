//
//  MSQMBannerView.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/7.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSQMBannerView.h"
#import "MSBaseCateModel.h"
#import "UIImageView+CornerRadius.h"

static const CGFloat kQMBannerHeight = 170.0f;
static const CGFloat kCircleRadius = 45.0f;
static const CGFloat kCircleCellHeight = 90.0f;

@interface MSQMCateCell : MSCircleBaseCell

//@property (nonatomic, strong) UIImageView *circleImgView;
@property (nonatomic, strong) UILabel *cateLabel;

@end

@implementation MSQMCateCell

- (void)setupSubviews {
    [super setupSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
    [self.imaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(kCircleRadius, kCircleRadius));
        make.centerX.equalTo(self);
    }];
    [self.imaView zy_cornerRadiusAdvance:kCircleRadius/2 rectCornerType:(UIRectCornerAllCorners)];
    
    _cateLabel = [[UILabel alloc]init];
    [_cateLabel setTextAlignment:(NSTextAlignmentCenter)];
    _cateLabel.font = [UIFont systemFontOfSize:12.0f];
    _cateLabel.textColor = [UIColor ms_colorWithHexString:@"#999b9d"];
    [self.contentView addSubview:_cateLabel];
    [_cateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imaView.mas_bottom).offset(5);
        make.left.equalTo(self);
        make.width.equalTo(self);
    }];
}

@end

@interface MSQMBannerView ()

@property (nonatomic, strong) MSCircleView *cateCircleView;

@end

@implementation MSQMBannerView

- (void)setupSubviewsFrame:(CGRect)frame {
    
    self.circleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kQMBannerHeight) urlImageArray:nil];
    self.circleView.backgroundColor = [UIColor whiteColor];
    self.circleView.cellClass = [MSBannerCell class];
    [self addSubview:self.circleView];
    self.circleView.autoScroll = YES;
    
    self.pageControl = [[UIPageControl alloc]init];
    [self addSubview:self.pageControl];
    
    self.backgroundColor = [UIColor whiteColor];
    _cateCircleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kCircleCellHeight) urlImageArray:nil perPageCount:5];
    [self addSubview:_cateCircleView];
    _cateCircleView.scrollByItem = YES;
    _cateCircleView.backgroundColor = [UIColor whiteColor];
    _cateCircleView.cellClass = [MSQMCateCell class];
    _cateCircleView.frame = CGRectMake(0, kQMBannerHeight, kSCREEN_WIDTH, kCircleCellHeight);
    
    [self updateFrame:frame];
}

- (void)updateFrame:(CGRect)frame {
    [super updateFrame:frame];
    self.circleView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kQMBannerHeight);
}

- (void)fillWithBannerModels:(NSArray *)bannerModels cateModels:(NSArray *)cateModels {
    [super fillWithBannerModels:bannerModels];
    
    NSMutableArray *urls = [NSMutableArray array];
    for (id<MSModelAdapterProtocol> cateModel in cateModels) {
        MSBaseCateModel *model = [cateModel convertToCateModel];
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
            [weakSelf.cateDelegate bannerView:weakSelf clickedCateCircleAtIndex:index cateId:cateModel.cateId];
        }
    }];
    
}

+ (CGSize)sectionHeaderViewSize {
    return CGSizeMake(kSCREEN_WIDTH, kQMBannerHeight + kCircleCellHeight);
}

@end
