//
//  DYPlayerToolView.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/17.
//  Copyright © 2016年 dengliwen. All rights reserved.
//
/**
 *  播放器的工具栏
 */
#import <UIKit/UIKit.h>

@class MSPlayerNomalSizeToolView;
@class MSPlayerFullScreenSizeToolView;

@protocol MSPlayerNomalSizeToolViewDelegate <NSObject>

// 点击暂停/播放 按钮
- (void)normalToolView:(MSPlayerNomalSizeToolView *)toolView willPlay:(BOOL)willPlay;
// 点击全屏
- (void)normalToolViewClickedFullScreenBtn:(MSPlayerNomalSizeToolView *)toolView;
// 点击返回
- (void)normalToolViewClickedBackBtn:(MSPlayerNomalSizeToolView *)toolView;

@end

@protocol MSPlayerFullScreenSizeToolViewDelegate <NSObject>

// 点击暂停/播放 按钮
- (void)fullSizeToolView:(MSPlayerFullScreenSizeToolView *)toolView willPlay:(BOOL)willPlay;
// 点击返回非全屏
- (void)fullSizeToolViewClickedBackBtn:(MSPlayerFullScreenSizeToolView *)toolView;
// 点击刷新按钮
- (void)fullSizeToolViewClickedRefreshBtn:(MSPlayerFullScreenSizeToolView *)toolView;

@end

/**
 *  竖屏下的工具条
 */
@interface MSPlayerNomalSizeToolView : UIView

@property (nonatomic, weak) id<MSPlayerNomalSizeToolViewDelegate> delegate;

@end

/**
 *  横屏下的工具条 (全屏)
 */
@interface MSPlayerFullScreenSizeToolView : UIView

@property (nonatomic, weak) id<MSPlayerFullScreenSizeToolViewDelegate> delegate;

@end
