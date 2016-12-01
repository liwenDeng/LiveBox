//
//  MSLiveViewController.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSLiveGroupViewController.h"
#import "ZJScrollPageView.h"
#import "MSAllLiveViewController.h"

@interface MSLiveGroupViewController ()

@property (nonatomic, strong) ZJScrollPageView *pageView;

@end

@implementation MSLiveGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"直播";
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
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style childVcs:childVcs parentViewController:self];
    // 额外的按钮响应的block
    __weak typeof(self) weakSelf = self;
    scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
        weakSelf.title = @"点击了extraBtn";
        NSLog(@"点击了extraBtn");
        
    };
    self.pageView = scrollPageView;
    [self.view addSubview:scrollPageView];
    
    //监听改变选中下标的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSelectVC:) name:kLiveGroupVCChangeIndexNoti object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (NSArray *)setupChildVcAndTitle {
    
    MSAllLiveViewController *vc1 = [[MSAllLiveViewController alloc]initWithLiveType:(MSLivetypeDouYu)];
    vc1.title = @"斗鱼TV";
    
    MSAllLiveViewController *vc2 = [[MSAllLiveViewController alloc]initWithLiveType:MSLivetypeQuanMin];
    vc2.title = @"全民TV";
    
    MSAllLiveViewController *vc3 = [[MSAllLiveViewController alloc]initWithLiveType:(MSLivetypePanda)];
    vc3.title = @"熊猫TV";
    
    NSArray *childVcs = [NSArray arrayWithObjects:vc1, vc2,vc3,nil];
    return childVcs;
}

#pragma mark - NSNotification Observe
- (void)changeSelectVC:(NSNotification*)noti {
    NSDictionary *info = noti.userInfo;
    NSInteger index = [info[@"index"] integerValue];
    [self.pageView setSelectedIndex:index animated:NO];
}

@end
