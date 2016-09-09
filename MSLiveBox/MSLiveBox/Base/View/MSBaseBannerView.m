//
//  MSBaseBannerView.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseBannerView.h"

#pragma mark - MSBannerCell

@interface MSBannerCell : MSCircleBaseCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MSBannerCell

- (void)setupSubviews {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kBannerHeight - kPageControlHeight, kSCREEN_WIDTH, kPageControlHeight)];
    [self.contentView addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.7;
    
    self.titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(kPageControlHeight);
        make.bottom.equalTo(self.contentView);
    }];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self.imaView setContentMode:(UIViewContentModeScaleAspectFill)];
}

@end

#pragma mark - MSBaseBannerView
@interface MSBaseBannerView ()

@end

@implementation MSBaseBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    _circleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kBannerHeight) urlImageArray:nil];
    _circleView.backgroundColor = [UIColor whiteColor];
    _circleView.cellClass = [MSBannerCell class];
    
    [self addSubview:_circleView];
    _circleView.autoScroll = YES;
    
    _pageControl = [[UIPageControl alloc]init];
    [self addSubview:_pageControl];
    _pageControl.numberOfPages = 0;
    [_pageControl sizeToFit];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(kPageControlHeight);
        make.bottom.equalTo(self.circleView);
    }];

    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}

- (void)fillWithBannerModels:(NSArray *)bannerModels {
    NSMutableArray *urls = [NSMutableArray array];
    for (id<MSModelAdapterProtocol> bannerModel in bannerModels) {
        MSBaseBannerModel *model = [bannerModel convertToUniteModel];
        [urls addObject:model.bigPic];
    }
    self.circleView.imageArray = urls;
    
    self.pageControl.numberOfPages = urls.count;
    __weak typeof (self)weakSelf = self;
    [self.circleView addPageScrollBlock:^(NSInteger index) {
        weakSelf.pageControl.currentPage = index;
    }];
    
    [self.circleView configCustomCell:^(MSCircleBaseCell *customCell, NSInteger index) {
        MSBannerCell *cell = (MSBannerCell *)customCell;
        MSBaseBannerModel *bannerModel = bannerModels[index];
        cell.titleLabel.text = bannerModel.title;
    }];
    
    [self.circleView addTapBlock:^(NSInteger index) {
        if ([weakSelf.delegate respondsToSelector:@selector(banner:clickedAtIndex:roomId:)]) {
            MSBaseBannerModel *bannerModel = bannerModels[index];
            [weakSelf.delegate banner:weakSelf clickedAtIndex:index roomId:bannerModel.roomId];
        }
    }];
}

+ (CGSize)sectionHeaderViewSize {
    return CGSizeMake(kSCREEN_WIDTH, kBannerHeight);
}

@end
