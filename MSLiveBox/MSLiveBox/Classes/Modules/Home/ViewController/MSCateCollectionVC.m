//
//  MSCateCollectionVC.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/24.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSCateCollectionVC.h"
#import "MSBaseRoomCell.h"
#import "MSLiveSteamViewController.h"

#import "MSNetworking+DYAPI.h"
#import "MSNetworking+QMAPI.h"
#import "MSNetworking+PandaAPI.h"

#import "MSRoomCellModel.h"
#import "DYRoomModel.h"
#import "QMRoomPlayerModel.h"
#import "PDRoomModel.h"

static NSString *const kNormalRoomCellID = @"kNormalRoomCell";

@interface MSCateCollectionVC ()

@property (nonatomic, strong) NSMutableArray *roomList;
@property (nonatomic, assign) NSInteger pageNo; //页码
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, assign) NSInteger totalCount;

@end

@implementation MSCateCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.roomList = [NSMutableArray array];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
    self.title = self.cateModel.title;
    [self refresh];
}

#pragma mark - MSHomeBaseCollectionVCDelegate
- (void)registCellClass {
    [self.collectionView registerClass:[MSBaseRoomCell class] forCellWithReuseIdentifier:kNormalRoomCellID];

}

#pragma mark - MSHTTPRequestProtocol
- (void)refresh {
    MSLivetype type = self.cateModel.type;
//    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    self.collectionView.mj_footer.hidden = YES;
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    switch (type) {
        case MSLivetypeDouYu:
        {
            self.pageNo = 0;
            [MSNetworking getDouyuLiveCateId:[self.cateModel.cateId integerValue] limit:20 offset:0 WithSuccess:^(NSDictionary *object) {
                self.roomList = [DYRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
                
                dispatch_group_leave(group);
            } failure:^(NSError *error) {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
                
                dispatch_group_leave(group);
            }];
        }
            break;
        case MSLivetypeQuanMin:
        {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            [MSNetworking getQMRoomCateListWithCateName:self.cateModel.cateId success:^(NSDictionary *object) {
                NSArray *roomList = [QMRoomPlayerModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
                self.roomList = [NSMutableArray arrayWithArray:roomList];
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
                
                dispatch_group_leave(group);
            } failure:^(NSError *error) {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
                
                dispatch_group_leave(group);
            }];
        }
            break;
        case MSLivetypePanda:
        {
            self.pageNo = 1;
            [MSNetworking getPandaAllLiveListWithCateId:self.cateModel.cateId pageNo:1 success:^(NSDictionary *object) {
                NSArray *roomList = [PDRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"][@"items"]];
                self.roomList = [NSMutableArray arrayWithArray:roomList];
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
                
                dispatch_group_leave(group);
            } failure:^(NSError *error) {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
                
                dispatch_group_leave(group);
            }];
        }
            break;
        default:
            dispatch_group_leave(group);
            break;
    }
    
    //refresh 完成 后才显示footer
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.collectionView.mj_footer.hidden = NO;
    });
}

- (void)loadMore {
    MSLivetype type = self.cateModel.type;
    switch (type) {
        case MSLivetypeDouYu:
        {
            self.pageNo++;
            [MSNetworking getDouyuLiveCateId:[self.cateModel.cateId integerValue] limit:20 offset:self.roomList.count WithSuccess:^(NSDictionary *object) {
                NSArray *arr = [DYRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"]];
                [self.roomList addObjectsFromArray:arr];
                [self.collectionView.mj_footer endRefreshing];
                if (arr.count < 20) {
                    //没有数据了
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.collectionView reloadData];
            } failure:^(NSError *error) {
                [self.collectionView.mj_footer endRefreshing];
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                [self.collectionView reloadData];
            }];
        }
            break;
        case MSLivetypeQuanMin:
        {
            
        }
            break;
        case MSLivetypePanda:
        {
            self.pageNo++;
            [MSNetworking getPandaAllLiveListWithCateId:self.cateModel.cateId pageNo:self.pageNo success:^(NSDictionary *object) {
                NSArray *roomList = [PDRoomModel mj_objectArrayWithKeyValuesArray:object[@"data"][@"items"]];
                self.totalCount = [object[@"data"][@"total"] integerValue];
                [self.roomList addObjectsFromArray:roomList];
                [self.collectionView.mj_footer endRefreshing];
                if (self.totalCount <= self.roomList.count) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
                [self.collectionView reloadData];
            } failure:^(NSError *error) {
                [self.collectionView.mj_footer endRefreshing];
                [self.collectionView reloadData];
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.roomList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSBaseRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalRoomCellID forIndexPath:indexPath];
    id<MSModelAdapterProtocol> model = self.roomList[indexPath.row];
    
    [cell fillWithRoomModel:model atIndexPath:indexPath];
    return cell;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id<MSModelAdapterProtocol> model = self.roomList[indexPath.row];
    MSLiveSteamViewController *liveVC = [[MSLiveSteamViewController alloc]init];
    liveVC.roomModel = [model convertToCellModel];
    liveVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:liveVC animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [MSBaseRoomCell cellSize];
}


@end
