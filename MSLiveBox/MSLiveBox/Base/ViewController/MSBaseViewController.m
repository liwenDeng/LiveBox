//
//  MSBaseViewController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseViewController.h"
#import "PYSearch.h"
#import "MSSearchResultGroupViewController.h"

@interface MSBaseViewController ()

@end

@implementation MSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self conformsToProtocol:@protocol(MSSearchButtonProtocol)] && [self respondsToSelector:@selector(searchButtonClicked)]) {
        UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemSearch) target:self action:@selector(searchButtonClicked)];
        [self.navigationItem setRightBarButtonItem:searchItem];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    //当前支持的旋转类型
//    return UIInterfaceOrientationMaskAll;
//}
//
//- (BOOL)shouldAutorotate
//{
//    // 是否支持旋转
//    return YES;
//}
//
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    // 默认进去类型
//    return   UIInterfaceOrientationPortrait;
//}

#pragma mark - MSSearchButtonProtocol
- (void)searchButtonClicked {
    // 1. 创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"PYExampleSearchPlaceholderText", @"搜索编程语言") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        MSSearchResultGroupViewController *cateVC = [[MSSearchResultGroupViewController alloc]initWithSearchText:searchText];
        [searchViewController.navigationController pushViewController:cateVC animated:YES];
    }];
    
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

@end
