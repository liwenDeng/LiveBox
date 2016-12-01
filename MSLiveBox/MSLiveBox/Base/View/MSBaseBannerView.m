//
//  MSBaseBannerView.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseBannerView.h"

#pragma mark - MSBannerCell

@interface MSBannerCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MSBannerCell

- (void)setupSubviews {
    UIView *bgView = [[UIView alloc]init];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.bottom.equalTo(self);
        make.height.mas_equalTo(kPageControlHeight);
    }];
    
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
        [self setupSubviewsFrame:frame];
    }
    return self;
}

- (void)setupSubviewsFrame:(CGRect)frame {
    _circleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kBannerHeight) urlImageArray:nil];
    _circleView.backgroundColor = [UIColor whiteColor];
    _circleView.cellClass = [MSBannerCell class];
    [self addSubview:_circleView];
    _circleView.autoScroll = YES;
    
    _pageControl = [[UIPageControl alloc]init];
    [self addSubview:_pageControl];
    
    [self updateFrame:frame];
}

- (void)updateFrame:(CGRect)frame {
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
    NSMutableArray *baseBanners = [NSMutableArray array];
    
    for (id<MSModelAdapterProtocol> bannerModel in bannerModels) {
        MSBaseBannerModel *model = [bannerModel convertToBannerModel];
        [urls addObject:model.bigPic];
        [baseBanners addObject:model];
    }
    self.circleView.imageArray = urls;
    
    self.pageControl.numberOfPages = urls.count;
    __weak __typeof(self) weakSelf = self;
    [self.circleView addPageScrollBlock:^(NSInteger index) {
        weakSelf.pageControl.currentPage = index;
    }];
    
    [self.circleView configCustomCell:^(MSCircleBaseCell *customCell, NSInteger index) {
        MSBannerCell *cell = (MSBannerCell *)customCell;
        MSBaseBannerModel *bannerModel = baseBanners[index];
        cell.titleLabel.text = bannerModel.title;
    }];
    
    [self.circleView addTapBlock:^(NSInteger index) {
        if ([weakSelf.delegate respondsToSelector:@selector(banner:clickedAtIndex:roomId:)]) {
            MSBaseBannerModel *bannerModel = baseBanners[index];
            [weakSelf.delegate banner:weakSelf clickedAtIndex:index roomId:bannerModel.roomId];
        }
    }];
}

+ (CGSize)sectionHeaderViewSize {
    return CGSizeMake(kSCREEN_WIDTH, kBannerHeight);
}

@end
