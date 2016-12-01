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
#import "DYBannerModel.h"
#import "MSBaseRoomCell.h"
#import "MSBaseBannerView.h"
#import "MSBaseSectionHeaderView.h"
#import "DYFaceRoomCell.h"
#import "MSBaseTabBarController.h"
#import "MSLiveSteamViewController.h"
#import "MSCateCollectionVC.h"

typedef enum : NSUInteger {
    DYSectionTypeBanner = 1,
    DYSectionTypeHot,
    DYSectionTypeFace,
    DYSectionTypeCate,
    DYSectionTypeUnknow,
} DYSectionType;

static NSString *const kBannerCellID = @"kBannerCell";
static NSString *const kNormalRoomCellID = @"kNormalRoomCell";
static NSString *const kFaceRoomCellID = @"kFaceRoomCell";
static NSString *const kSectionHeaderID = @"kSectionHeaderId";

@interface MSDYHomeVC ()<MSBaseBannerViewDelegate,MSBaseSectionHeaderViewDelegate>

@property (nonatomic, strong) NSArray *bannerList;   //轮播图-> section0 header
@property (nonatomic, strong) NSArray *bigDataList;  //最热->section1
@property (nonatomic, strong) NSArray *faceList;    //颜值-section2
@property (nonatomic, strong) NSArray *hotCateList; //分类-section3+

@property (nonatomic, strong) NSMutableArray *sectionList;

@end

@implementation MSDYHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bannerList = [NSArray array];
    self.bigDataList = [NSArray array];
    self.faceList = [NSArray array];
    self.hotCateList = [NSArray array];
    self.sectionList = [NSMutableArray array];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
}

#pragma mark - MSHomeBaseCollectionVCDelegate
- (void)registCellClass {
    [self.collectionView registerClass:[MSBaseBannerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kBannerCellID];
    [self.collectionView registerClass:[MSBaseSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderID];
    
    [self.collectionView registerClass:[MSBaseRoomCell class] forCellWithReuseIdentifier:kNormalRoomCellID];
    [self.collectionView registerClass:[DYFaceRoomCell class] forCellWithReuseIdentifier:kFaceRoomCellID];
}

#pragma mark - MSHTTPRequestProtocol
- (void)refresh {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    //获取轮播图
    [MSNetworking getDouyuSlideBanners:^(NSDictionary *object) {
        NSLog(@"4.获取轮播图成功");
        NSArray *array = [DYBannerModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        self.bannerList = array;
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    //获取最热
    [MSNetworking getDouyuBigDataInfos:^(NSDictionary *object) {
        NSLog(@"1.获取最热成功");
        NSArray *array = [DYRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        self.bigDataList = array;
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    //获取颜值
    [MSNetworking getDouyuFaceInfos:^(NSDictionary *object) {
        NSLog(@"2.获取颜值成功");
        dispatch_group_leave(group);
        NSArray *array = [DYRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        self.faceList = array;
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    //获取热门分类
    [MSNetworking getDouyuHotCateListInfos:^(NSDictionary *object) {
        NSLog(@"3.获取热门成功");
        NSArray *cateList = [DYRoomCateList mj_objectArrayWithKeyValuesArray:object[@"data"]];
        self.hotCateList = cateList;
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //所有数据请求完成;
        [self.sectionList removeAllObjects];
        if (self.bannerList.count > 0) [_sectionList addObject:self.bannerList];
        if (self.bigDataList.count > 0) [_sectionList addObject:self.bigDataList];
        if (self.faceList.count > 0) [_sectionList addObject:self.faceList];
        if (self.hotCateList.count > 0) [_sectionList addObjectsFromArray:self.hotCateList];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    });

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionList.count; //加轮播图
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    DYSectionType type = [self modelTypeAtSection:section];
    switch (type) {
        case DYSectionTypeBanner:
            return 0;
            break;
        case DYSectionTypeHot:
        {
            NSArray *roomList = self.sectionList[section];
            return roomList.count;
        }
        case DYSectionTypeFace:
        {
            NSArray *roomList = self.sectionList[section];
            return roomList.count;
        }
            break;
        case DYSectionTypeCate:
        {
            DYRoomCateList *cateList = self.sectionList[section];
            return cateList.room_list.count;
        }
            break;
        default:
            return 0;
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSBaseRoomCell *cell = [[MSBaseRoomCell alloc]init];
    DYSectionType type = [self modelTypeAtSection:indexPath.section];
    DYRoomModel *model = [[DYRoomModel alloc]init];
    switch (type) {
        case DYSectionTypeBanner:
        {
            return cell;
        }
            break;
        case DYSectionTypeHot:
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalRoomCellID forIndexPath:indexPath];
            NSArray *modelList = self.sectionList[indexPath.section];
            model = modelList[indexPath.row];
        }
            break;
        case DYSectionTypeFace:
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFaceRoomCellID forIndexPath:indexPath];
            NSArray *modelList = self.sectionList[indexPath.section];
            model = modelList[indexPath.row];
            
            break;
        }
        case DYSectionTypeCate:
        {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalRoomCellID forIndexPath:indexPath];
            DYRoomCateList *list = self.sectionList[indexPath.section];
            model = list.room_list[indexPath.row];
        }
            
        default:
            break;
    }
    
    [cell fillWithRoomModel:model atIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    DYSectionType type = [self modelTypeAtSection:indexPath.section];
    switch (type) {
        case DYSectionTypeBanner:
        {
            MSBaseBannerView *bannerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kBannerCellID forIndexPath:indexPath];
            [bannerView fillWithBannerModels:self.sectionList[indexPath.section]];
            bannerView.delegate = self;
            return bannerView;
        }
            break;
        case DYSectionTypeHot:
        {
            MSBaseSectionHeaderView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderID forIndexPath:indexPath];
            [sectionHeader fillWithTagName:@"热门" atIndexPath:indexPath];
            sectionHeader.delegate = self;
            return sectionHeader;
        }
            break;
        case DYSectionTypeFace:
        {
            MSBaseSectionHeaderView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderID forIndexPath:indexPath];
            [sectionHeader fillWithTagName:@"颜值" atIndexPath:indexPath];
            sectionHeader.delegate = self;
            return sectionHeader;
        }
            break;
        case DYSectionTypeCate:
        {
            MSBaseSectionHeaderView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderID forIndexPath:indexPath];
            DYRoomCateList *list = self.sectionList[indexPath.section];
            [sectionHeader fillWithTagName:list.tag_name atIndexPath:indexPath];
            sectionHeader.delegate = self;
            return sectionHeader;
        }
            break;
        default:
            return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderID forIndexPath:indexPath];
            break;
    }
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DYSectionType type = [self modelTypeAtSection:indexPath.section];
    DYRoomModel *model = [[DYRoomModel alloc]init];
    if (type == DYSectionTypeCate) {
        DYRoomCateList *cateList = self.sectionList[indexPath.section];
        model = cateList.room_list[indexPath.row];
    }else {
        NSArray *roomList = self.sectionList[indexPath.section];
        model = roomList[indexPath.row];
    }
    MSLiveSteamViewController *liveVC = [[MSLiveSteamViewController alloc]init];
    liveVC.roomModel = [model convertToCellModel];
    liveVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:liveVC animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    DYSectionType type = [self modelTypeAtSection:section];
//    switch (type) {
//        case DYSectionTypeBanner:
//            return [MSBaseBannerView sectionHeaderViewSize];
//            break;
//        default:
//            return [MSBaseSectionHeaderView sectionHeaderViewSize];
//            break;
//    }
    
    switch (type) {
        case DYSectionTypeBanner:
            return [MSBaseBannerView sectionHeaderViewSize];
            break;
        case DYSectionTypeHot:
            return [MSBaseSectionHeaderView sectionHeaderViewSize];
            break;
        case DYSectionTypeFace:
            return [MSBaseSectionHeaderView sectionHeaderViewSize];
            break;
        case DYSectionTypeCate:
        {
            DYRoomCateList *cateList = self.sectionList[section];
            if (cateList.room_list.count > 0) {
                return [MSBaseSectionHeaderView sectionHeaderViewSize];
            }
            return CGSizeZero;
        }
        default:
            return CGSizeZero;
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYSectionType type = [self modelTypeAtSection:indexPath.section];
    switch (type) {
        case DYSectionTypeFace:
            return [DYFaceRoomCell cellSize];
            break;
        default:
            return [MSBaseRoomCell cellSize];
            break;
    }
}

#pragma mark - MSBaseSectionHeaderViewDelegate
- (void)sectionHeaderView:(MSBaseSectionHeaderView *)sectionHeaderView clickedMoreButtonAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        //跳转到直播
        MSBaseTabBarController *tabController = (MSBaseTabBarController *)[self cyl_tabBarController];
        tabController.selectedIndex = 1;
        
        //通知选中直播页面第一个
        [[NSNotificationCenter defaultCenter]postNotificationName:kLiveGroupVCChangeIndexNoti object:nil userInfo:@{@"index":@(0)}];
        
    }else if (indexPath.section == 2) {
        //颜值
    }else {
//        //跳转到分类
        DYRoomCateList *list = self.sectionList[indexPath.section];
        MSCateCollectionVC *detailVC = [[MSCateCollectionVC alloc]init];
        detailVC.cateModel = [list convertToCateModel];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - MSBaseBannerViewDelegate
- (void)banner:(MSBaseBannerView *)banner clickedAtIndex:(NSInteger)index roomId:(NSString *)roomId {
    NSArray *banners = self.sectionList[0];
    DYBannerModel *bannerModel = banners[index];
    MSLiveSteamViewController *live = [[MSLiveSteamViewController alloc]init];
    
    live.roomModel = [bannerModel convertToCellModel];
    [self.navigationController pushViewController:live animated:YES];
}

- (DYSectionType)modelTypeAtSection:(NSInteger )section {
    if (self.sectionList.count < section) {
        return DYSectionTypeUnknow;
    }
    if([self.sectionList[section] isKindOfClass:[DYRoomCateList class]]) {
        return DYSectionTypeCate;
    }
    if ([self.sectionList[section] isKindOfClass:[NSArray class]]) {
        NSArray *list = self.sectionList[section];
        if ([list[0] isKindOfClass:[DYBannerModel class]]) {
            return DYSectionTypeBanner;
        }
        if ([list[0] isKindOfClass:[DYRoomModel class]]) {
            DYRoomModel *roomModel = list[0];
            if ([self.bigDataList containsObject:roomModel]) {
                return DYSectionTypeHot;
            }
            if ([self.faceList containsObject:roomModel]) {
                return DYSectionTypeFace;
            }
        }
    }
    return DYSectionTypeUnknow;
}

@end
