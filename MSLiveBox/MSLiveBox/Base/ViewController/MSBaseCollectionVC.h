//
//  MSHomeBaseCollectionVC.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//
/**
 *  所有平台的首页都继承自这个VC
 *  所有平台首页布局类似，只是数据源不同
 */
#import "MSBaseViewController.h"
#import "MSLiveCollectionView.h"
#import <MJRefresh.h>

@protocol MSBaseCollectionVCProtocol <NSObject>

@required
/**
 *  必须要注册collectionView的cell类型
 */
- (void)registCellClass;

@end

@interface MSBaseCollectionVC : MSBaseViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MSBaseCollectionVCProtocol>

@property (nonatomic, strong) MSLiveCollectionView *collectionView;

@end
