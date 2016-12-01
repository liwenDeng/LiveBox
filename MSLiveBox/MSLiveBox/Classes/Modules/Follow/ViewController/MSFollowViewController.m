//
//  MSFollowViewController.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSFollowViewController.h"
#import "ZJScrollPageView.h"
#import "MSCateListViewController.h"

@interface MSFollowViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) ZJScrollPageView* pageView;

@end

@implementation MSFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    [searchBar sizeToFit];
    searchBar.delegate = self;
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
    
    self.title = @"搜索";
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
    
    MSCateListViewController *vc1 = [[MSCateListViewController alloc]initWithLiveType:(MSLivetypeDouYu)];
    vc1.title = @"斗鱼TV";
    
    MSCateListViewController *vc2 = [[MSCateListViewController alloc]initWithLiveType:(MSLivetypeQuanMin)];
    vc2.title = @"全民TV";
    
    MSCateListViewController *vc3 = [[MSCateListViewController alloc]initWithLiveType:(MSLivetypePanda)];
    vc3.title = @"熊猫TV";
    
    NSArray *childVcs = [NSArray arrayWithObjects:vc1, vc2,vc3,nil];
    return childVcs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

@end
