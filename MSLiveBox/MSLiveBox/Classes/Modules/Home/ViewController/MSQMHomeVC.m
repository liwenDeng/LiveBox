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

@interface MSQMHomeVC () <MSBaseBannerViewDelegate,MSQMBannerViewDelegate,MSBaseSectionHeaderViewDelegate>

@property (nonatomic, strong) NSArray *bannerList;  //轮播图
@property (nonatomic, strong) NSArray *remenCates;  //轮播图下的分类圆圈

@property (nonatomic, strong) QMCateModel* remommenCate;  //精彩推荐分区头
@property (nonatomic, strong) NSArray *recommendations; //精彩推荐数据需要单独处理
@property (nonatomic, assign) NSInteger recomStartIndex;//精彩推荐的第一所处下标
@property (nonatomic, assign) NSInteger recomEndIndex; //精彩推荐第二个所处下标

@property (nonatomic, strong) NSArray *sectionHeaders; //分区头
@property (nonatomic, strong) NSMutableArray *sectionDatas; //分区下的数据

@end

@implementation MSQMHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bannerList = [NSArray array];
    self.remenCates = [NSArray array];
    self.sectionHeaders = [NSArray array];
    self.sectionDatas = [NSMutableArray array];
    self.recommendations = [NSArray array];
    self.recomStartIndex = 0;
    self.recommendations = 0;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
}

- (void)registCellClass {
    [self.collectionView registerClass:[MSQMBannerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kBannerCellID];
    [self.collectionView registerClass:[MSBaseSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderID];
    
    [self.collectionView registerClass:[MSBaseRoomCell class] forCellWithReuseIdentifier:kNormalRoomCellID];
}

#pragma mark - MSHTTPRequestProtocol
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
            if ([cate.slug isEqualToString:@"ios-recommendation"]) {
                self.remommenCate = cate;
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
        
        //解析精彩推荐
        NSArray *recommendations = [QMLinkModel mj_objectArrayWithKeyValuesArray:object[@"ios-recommendation"]];
        self.recommendations = recommendations;
        if (recommendations.count > 1) {
            self.recomStartIndex = 0;
            self.recomEndIndex = 1;
        }
        
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
    return self.sectionHeaders.count > 0 ? self.sectionHeaders.count + 2 : 0; //加轮播图 + 精彩推荐
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0: //Banner Section
            return 0;
            break;
        case 1://精彩推荐
            return 2;
            break;
        default:
        {
            NSArray *linkModels = self.sectionDatas[section - 2];
            return linkModels.count;
        }
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSBaseRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalRoomCellID forIndexPath:indexPath];
    QMLinkModel *linkModel = [[QMLinkModel alloc]init];
    if (indexPath.section == 1) {
        //精彩推荐
        if (indexPath.row == 0) {
            linkModel = self.recommendations[self.recomStartIndex];
        }else {
            linkModel = self.recommendations[self.recomEndIndex];
        }
        [cell fillWithRoomModel:linkModel.link_object atIndexPath:indexPath];
        return cell;
    }else {
        NSArray *linkModels = self.sectionDatas[indexPath.section - 2];
        linkModel = linkModels.count > indexPath.row ? linkModels[indexPath.row] : linkModel;
        [cell fillWithRoomModel:linkModel.link_object atIndexPath:indexPath];
        return cell;
    }
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
            QMCateModel *cate = [[QMCateModel alloc]init];
            if (indexPath.section == 1) {
                cate = self.remommenCate;
                [sectionHeader qm_fillWithTagName:cate.name atIndexPath:indexPath moreBtnName:@"换一换"];
            }else {
                cate = self.sectionHeaders[indexPath.section - 2];
                [sectionHeader qm_fillWithTagName:cate.name atIndexPath:indexPath moreBtnName:@"瞅瞅"];
            }
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

#pragma mark - MSBaseBannerViewDelegate
- (void)banner:(MSBaseBannerView *)banner clickedAtIndex:(NSInteger)index roomId:(NSString *)roomId {
    
}

#pragma mark - MSQMBannerViewDelegate
- (void)bannerView:(MSQMBannerView *)bannerView clickedCateCircleAtIndex:(NSInteger)index cateId:(NSString *)cateId {
    
}

#pragma mark - MSBaseSectionHeaderViewDelegate
- (void)sectionHeaderView:(MSBaseSectionHeaderView *)sectionHeaderView clickedMoreButtonAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        //精彩推荐
        self.recomStartIndex += 2;
        if (self.recomStartIndex >= self.recommendations.count) {
            self.recomStartIndex = 0;
        }
        self.recomEndIndex = self.recomStartIndex + 1;
        if (self.recomEndIndex >= self.recommendations.count) {
            self.recomEndIndex = 1;
        }
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }
}

@end
