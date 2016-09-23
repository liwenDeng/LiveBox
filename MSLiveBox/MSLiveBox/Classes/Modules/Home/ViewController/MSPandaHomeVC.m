//
//  PandaHomeVC.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/23.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSPandaHomeVC.h"
#import "PDRoomModel.h"
#import "PDBannerModel.h"
#import "MSBaseRoomCell.h"
#import "MSBaseBannerView.h"
#import "MSBaseSectionHeaderView.h"
#import "MSNetWorking+PandaApi.h"
#import "MSLiveSteamViewController.h"

static NSString *const kBannerCellID = @"kPDBannerCell";
static NSString *const kNormalRoomCellID = @"kPDNormalRoomCell";
static NSString *const kSectionHeaderID = @"kPDSectionHeaderId";

@interface MSPandaHomeVC () <MSHomeBaseCollectionVCDelegate,MSBaseBannerViewDelegate,MSBaseSectionHeaderViewDelegate>

@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) NSArray *sectionList;

@end

@implementation MSPandaHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bannerList = [NSArray array];
    self.sectionList = [NSArray array];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
}

- (void)registCellClass {
    [self.collectionView registerClass:[MSBaseBannerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kBannerCellID];
    [self.collectionView registerClass:[MSBaseSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderID];
    
    [self.collectionView registerClass:[MSBaseRoomCell class] forCellWithReuseIdentifier:kNormalRoomCellID];
}

#pragma mark - MSHTTPRequestProtocol
- (void)refresh {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [MSNetworking getPandaBannersWithSuccess:^(NSDictionary *object) {
        MSLog(@"BannerList:%@",object);
        self.bannerList = [PDBannerModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [MSNetworking getPandaHomeRoomListWithSuccess:^(NSDictionary *object) {
        MSLog(@"HomeRoomList:%@",object);
        self.sectionList = [PDRoomSectionModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //所有数据请求完成;
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionList.count + 1;  //+轮播
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0: //Banner Section
            return 0;
            break;
        default:
        {
            PDRoomSectionModel *sectionModel = self.sectionList[section - 1];
            return sectionModel.items.count;
        }
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSBaseRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalRoomCellID forIndexPath:indexPath];
    PDRoomModel *roomModel = [[PDRoomModel alloc]init];

    PDRoomSectionModel *sectionModel = self.sectionList[indexPath.section - 1];
    NSArray *roomModels = sectionModel.items;
    roomModel = roomModels.count > indexPath.row ? roomModels[indexPath.row] : roomModel;
    [cell fillWithRoomModel:roomModel atIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0: //banner
        {
            MSBaseBannerView *bannerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kBannerCellID forIndexPath:indexPath];
            [bannerView fillWithBannerModels:self.bannerList];
            bannerView.delegate = self;
            return bannerView;
        }
            break;
        default:
        {
            MSBaseSectionHeaderView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeaderID forIndexPath:indexPath];
            PDRoomSectionModel *cate = self.sectionList[indexPath.section - 1];
            if (indexPath.section == 1) {
                [sectionHeader pd_fillWithTagName:cate.type.cname cateIcon:cate.type.icon showMore:NO atIndexPath:indexPath];
            }else {
                [sectionHeader pd_fillWithTagName:cate.type.cname cateIcon:cate.type.icon showMore:YES atIndexPath:indexPath];
            }
            sectionHeader.delegate = self;
            return sectionHeader;
        }
            break;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    PDRoomModel *model = [[PDRoomModel alloc]init];

    PDRoomSectionModel *sectionModel = self.sectionList[indexPath.section - 1];
    NSArray *roomList = sectionModel.items;
    model = roomList[indexPath.row];
    MSLiveSteamViewController *liveVC = [[MSLiveSteamViewController alloc]init];
    liveVC.roomModel = [model convertToUniteModel];
    liveVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:liveVC animated:YES];
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0://banner
            return [MSBaseBannerView sectionHeaderViewSize];
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

#pragma mark - MSBaseSectionHeaderViewDelegate
- (void)sectionHeaderView:(MSBaseSectionHeaderView *)sectionHeaderView clickedMoreButtonAtIndexPath:(NSIndexPath *)indexPath {

}

@end
