//
//  MSQMHomeVC.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/7.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSQMHomeVC.h"
#import "QMBannerModel.h"
#import "QMRoomModel.h"
#import "QMCateModel.h"
#import "QMRemenCateModel.h"
#import "MSNetworking+QMAPI.h"
#import "MSBaseRoomCell.h"
#import "MSQMBannerView.h"
#import "MSBaseSectionHeaderView.h"

static NSString *const kBannerCellID = @"kQMBannerCell";
static NSString *const kNormalRoomCellID = @"kNormalRoomCell";
static NSString *const kSectionHeaderID = @"kSectionHeaderId";

@interface MSQMHomeVC ()

@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) NSArray *remenCates;
@property (nonatomic, strong) NSArray *sectionHeaders;
@property (nonatomic, strong) NSMutableArray *sectionDatas;

@end

@implementation MSQMHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bannerList = [NSArray array];
    self.sectionHeaders = [NSArray array];
    self.sectionDatas = [NSMutableArray array];
}

- (void)registCellClass {
    [self.collectionView registerClass:[MSQMBannerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kBannerCellID];
    [self.collectionView registerClass:[MSBaseSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderID];
    
    [self.collectionView registerClass:[MSBaseRoomCell class] forCellWithReuseIdentifier:kNormalRoomCellID];
}

- (void)refresh {

    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [MSNetworking getQMBannersWithSuccess:^(NSDictionary *object) {
        MSLog(@"BannerList:%@",object);
        NSArray *bannerList = [QMBannerModel mj_objectArrayWithKeyValuesArray:object[@"ios-focus"]];
        self.bannerList = bannerList;
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [MSNetworking getQMHomeRoomListWithSuccess:^(NSDictionary *object) {
        MSLog(@"HomeRoomList:%@",object);
        NSArray *list = [QMCateModel mj_objectArrayWithKeyValuesArray:object[@"list"]];
        NSMutableArray *listCopy = [NSMutableArray arrayWithArray:list];
        for (QMCateModel *cate in list) {
            if ([cate.slug isEqualToString:@"ios-remenfenlei"]) {
                [listCopy removeObject:cate];
            }
            if ([cate.slug isEqualToString:@"ios-shouyelunbo"]) {
                [listCopy removeObject:cate];
            }
        }
        self.sectionHeaders = listCopy; //每个section 的分区头数据
        [self.sectionDatas removeAllObjects];
        for (QMCateModel *cate in listCopy) {
            NSString *slugName = cate.slug;
            NSArray *roomList = [QMLinkModel mj_objectArrayWithKeyValuesArray:object[slugName]];
            [self.sectionDatas addObject:roomList];//每个section下的roomList数组
        }
        
        //解析分类轮播Model
        NSArray *remenArray = [QMRemenCateModel mj_objectArrayWithKeyValuesArray:object[@"ios-remenfenlei"]];
        self.remenCates = remenArray;
        
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
        //所有数据请求完成;
        [self.collectionView reloadData];
        
    });
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionHeaders.count + 1; //加轮播图
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0: //Banner Section
            return 0;
            break;
        default:
        {
            NSArray *linkModels = self.sectionDatas[section - 1];
            return linkModels.count;
        }
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSBaseRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalRoomCellID forIndexPath:indexPath];
    NSArray *linkModels = self.sectionDatas[indexPath.section - 1];
    QMLinkModel *linkModel = linkModels[indexPath.row];
    [cell fillWithRoomModel:linkModel.link_object atIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0: //banner
        {
            MSQMBannerView *bannerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kBannerCellID forIndexPath:indexPath];
            [bannerView fillWithBannerModels:self.bannerList cateModels:self.remenCates];
            bannerView.delegate = self;
            bannerView.cateDelegate = self;
            return bannerView;
        }
            break;
        default:
        {
            MSBaseSectionHeaderView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderID forIndexPath:indexPath];
            QMCateModel *list = self.sectionHeaders[indexPath.section - 1];
            [sectionHeader fillWithTagName:list.name atIndexPath:indexPath];
            sectionHeader.delegate = self;
            return sectionHeader;
        }
            break;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0://banner
            return [MSQMBannerView sectionHeaderViewSize];
            break;
        default:
            return [MSBaseSectionHeaderView sectionHeaderViewSize];
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return CGSizeZero;
            break;
        default:
            return [MSBaseRoomCell cellSize];
            break;
    }
}


@end
