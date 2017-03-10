//
//  MSSearchResultGroupViewController.m
//  MSLiveBox
//
//  Created by 邓利文 on 2017/2/27.
//  Copyright © 2017年 dengliwen. All rights reserved.
//

#import "MSSearchResultGroupViewController.h"
#import "ZJScrollPageView.h"
#import "MSSearchResultViewController.h"

@interface MSSearchResultGroupViewController ()

@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, strong) ZJScrollPageView* pageView;

@end

@implementation MSSearchResultGroupViewController

- (instancetype)initWithSearchText:(NSString *)searchText {
    if (self = [super init]) {
        _keyword = searchText;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.keyword;
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    // 显示附加的按钮
    style.showExtraButton = YES;
    // 设置附加按钮的背景图片
    style.extraBtnBackgroundImageName = @"extraBtnBackgroundImage";
    // 设置子控制器 --- 注意子控制器需要设置title, 将用于对应的tag显示title
    NSArray *childVcs = [NSArray arrayWithArray:[self setupChildVcAndTitle]];
    // 初始化
    self.pageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style childVcs:childVcs parentViewController:self];
    // 额外的按钮响应的block
    __weak typeof(self) weakSelf = self;
    self.pageView.extraBtnOnClick = ^(UIButton *extraBtn){
        weakSelf.title = @"点击了extraBtn";
        NSLog(@"点击了extraBtn");
        
    };
    [self.view addSubview:self.pageView];

}

- (NSArray *)setupChildVcAndTitle {
    
    MSSearchResultViewController *vc1 = [[MSSearchResultViewController alloc]initWithSearchText:self.keyword type:(MSLivetypeDouYu)];
    vc1.title = @"斗鱼TV";
    
    MSSearchResultViewController *vc2 = [[MSSearchResultViewController alloc]initWithSearchText:self.keyword type:(MSLivetypeQuanMin)];
    vc2.title = @"全民TV";
    
    MSSearchResultViewController *vc3 = [[MSSearchResultViewController alloc]initWithSearchText:self.keyword type:(MSLivetypePanda)];
    vc3.title = @"熊猫TV";
    
    NSArray *childVcs = [NSArray arrayWithObjects:vc1, vc2,vc3,nil];
    return childVcs;
}


@end
