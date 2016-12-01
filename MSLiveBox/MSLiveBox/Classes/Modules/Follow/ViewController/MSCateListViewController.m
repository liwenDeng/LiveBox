//
//  MSCateListViewController.m
//  MSLiveBox
//
//  Created by 邓利文 on 2016/11/29.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSCateListViewController.h"
#import "MSCommonCateCell.h"
#import "MSNetworking+DYAPI.h"
#import "MSNetworking+PandaAPI.h"
#import "MSNetworking+QMAPI.h"
#import <MJRefresh.h>
#import "MSBaseCateModel.h"
#import "DYRoomModel.h"
#import "MSCateCollectionVC.h"
#import "PDRoomModel.h"
#import "QMCommonCate.h"

static NSString *const kCommonCateCellID = @"kCommonCateCell";

@interface MSCateListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) MSLivetype liveType;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *cateList;

@end

@implementation MSCateListViewController

- (instancetype)initWithLiveType:(MSLivetype)type {
    if (self = [super init]) {
        self.liveType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerClass:[MSCommonCateCell class] forCellWithReuseIdentifier:kCommonCateCellID];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(refresh)]) {
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    }
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kSCREEN_WIDTH);
    }];
}

#pragma mark - MSHTTPRequestProtocol
- (void)refresh {
    self.collectionView.mj_footer.hidden = YES;
    
    switch (self.liveType) {
        case MSLivetypeDouYu:
        {
            [MSNetworking getDouyuCommonCates:^(NSDictionary *object) {
                self.cateList = [DYRoomCateList mj_objectArrayWithKeyValuesArray:object[@"data"]];
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
            } failure:^(NSError *error) {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
            }];
        }
            break;
        case MSLivetypePanda:
        {
            [MSNetworking getPandaCommonCates:^(NSDictionary *object) {
                self.cateList = [PDRoomSectionType mj_objectArrayWithKeyValuesArray:object[@"data"]];
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
            } failure:^(NSError *error) {
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
            }];
        }
            break;
        case MSLivetypeQuanMin:
        {
            [MSNetworking getQMCommonCates:^(NSDictionary *object) {
                self.cateList = [QMCommonCate mj_objectArrayWithKeyValuesArray:object];
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
            } failure:^(NSError *error) {
                [self.collectionView.mj_header endRefreshing];
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
    return self.cateList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSCommonCateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCommonCateCellID forIndexPath:indexPath];
    id<MSModelAdapterProtocol> model = self.cateList[indexPath.row];
    
    [cell fillWithRoomModel:model atIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id<MSModelAdapterProtocol> model = self.cateList[indexPath.row];
    MSBaseCateModel *cate = [model convertToCateModel];
    MSCateCollectionVC *detailVC = [[MSCateCollectionVC alloc]init];
    detailVC.cateModel = cate;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.parentViewController.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [MSCommonCateCell cellSize];
}

@end
