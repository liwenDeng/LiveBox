//
//  MSDYHomeVC.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSDYHomeVC.h"
#import "MSNetworking+DYAPI.h"
#import "DYRoomModel.h"

@interface MSDYHomeVC ()

@property (nonatomic, strong) NSMutableArray *bigDataList;  //最热
@property (nonatomic, strong) NSMutableArray *faceList;    //颜值
@property (nonatomic, strong) NSMutableArray *hotCateList; //分类
@property (nonatomic, strong) NSMutableArray *sectionList;

@property (nonatomic, strong) NSMutableArray *bannerList;   //轮播图

@end

@implementation MSDYHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - MSHomeBaseCollectionVCDelegate
- (void)registCellClass {
    
}

#pragma mark - MSHTTPRequestDelegate
- (void)refresh {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    //获取最热
    [MSNetworking getDouyuBigDataInfos:^(NSDictionary *object) {
        NSLog(@"1.获取最热成功");
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    //获取颜值
    [MSNetworking getDouyuFaceInfos:^(NSDictionary *object) {
        NSLog(@"2.获取颜值成功");
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    //获取热门分类
    [MSNetworking getDouyuHotCateListInfos:^(NSDictionary *object) {
        NSLog(@"3.获取热门成功");
//        NSMutableArray *hotListDics = [NSMutableArray arrayWithArray:list.data];
//        NSMutableArray *hotCateLists = [NSMutableArray array];
//        for (NSDictionary *dic in hotListDics) {
//            DYHotCate *hotCate = [DYHotCate yy_modelWithDictionary:dic];
//            [hotCateLists addObject:hotCate];
//        }
//        self.hotCateList = [NSMutableArray arrayWithArray:hotCateLists];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    //获取轮播图
    [MSNetworking getDouyuSlideBanners:^(NSDictionary *object) {
        NSLog(@"4.获取轮播图成功");
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //所有数据请求完成;
        if (self.bigDataList.count > 0) [_sectionList addObject:self.bigDataList];
        if (self.faceList.count > 0) [_sectionList addObject:self.faceList];
        if (self.hotCateList.count > 0) [_sectionList addObjectsFromArray:self.hotCateList];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    });

}

@end
