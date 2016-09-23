//
//  MSBaseSectionHeaderView.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseSectionHeaderView.h"

#define kLineColor @"f3f1f4"
#define kArrowBtnTitleColor @"#8d8b8e"

@interface MSBaseSectionHeaderView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *arrowBtn;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation MSBaseSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    UIView *lineView = ({
        UIView *view = [[UIView alloc]init];
        [self addSubview:view];
        view.backgroundColor = [UIColor ms_colorWithHexString:kLineColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.equalTo(self);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];
        
        view;
    });
    
    _iconView = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.equalTo(lineView.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
//        view.backgroundColor = [UIColor redColor];
        view;
    });
    
    _titleLabel = ({
        UILabel *view = [[UILabel alloc]init];
        [self addSubview:view];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        view.text = @"最热";
        [view sizeToFit];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconView.mas_right).offset(10);
            make.centerY.equalTo(_iconView);
        }];
        
        view;
    });
    
    _arrowBtn = ({
        UIButton *view = [[UIButton alloc]init];
        [self addSubview:view];
        [view.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [view setTitle:@"更多" forState:(UIControlStateNormal)];
        [view sizeToFit];
        [view setTitleColor:[UIColor ms_colorWithHexString:kArrowBtnTitleColor] forState:(UIControlStateNormal)];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(_titleLabel);
        }];
        
        [view addTarget:self action:@selector(moreBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        view;
    });
}

- (void)fillWithTagName:(NSString *)tagName atIndexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = tagName;
    self.indexPath = indexPath;
}

- (void)qm_fillWithTagName:(NSString *)tagName atIndexPath:(NSIndexPath *)indexPath moreBtnName:(NSString *)btnName {
    [self fillWithTagName:tagName atIndexPath:indexPath];
    [self.arrowBtn setTitle:btnName forState:(UIControlStateNormal)];
}

- (void)pd_fillWithTagName:(NSString *)tagName cateIcon:(NSString*)url showMore:(BOOL)show atIndexPath:(NSIndexPath *)indexPath {
    [self fillWithTagName:tagName atIndexPath:indexPath];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:url]];
    self.arrowBtn.hidden = !show;
}

- (void)moreBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sectionHeaderView:clickedMoreButtonAtIndexPath:)]) {
        [self.delegate sectionHeaderView:self clickedMoreButtonAtIndexPath:self.indexPath];
    }
}

+ (CGSize)sectionHeaderViewSize {
    return CGSizeMake(kSCREEN_WIDTH, 50);
}


@end
