//
//  MSBasePlayerView.h
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 锁屏状态
 */
typedef enum : NSUInteger {
    PlayerViewLocked,
    PlayerViewUnLocked,
} PlayerViewLockState;

typedef enum : NSUInteger {
    PlayerViewRotateNomalSize,//普通大小
    PlayerViewRotateFullScreenSize,//全屏
} PlayerViewRotateState;

@class MSBasePlayerView;

@protocol MSBasePlayerViewDelegate <NSObject>

/**
 *  全屏旋转
 */
- (void)playerView:(MSBasePlayerView*)view rotateState:(PlayerViewRotateState)state;
- (void)playerViewBackButtonClicked:(MSBasePlayerView *)view;
- (void)playerViewRefreshButtonClicked:(MSBasePlayerView *)view;

@end


@interface MSBasePlayerView : UIView

@property (nonatomic, assign) PlayerViewLockState lockState;//锁屏状态
@property (nonatomic, assign) PlayerViewRotateState rotateState;  //是否全屏
@property (nonatomic, weak) id<MSBasePlayerViewDelegate> delegate;

- (void)playWithVideoSrc:(NSString *)src;

- (void)showNomalToolView:(BOOL)show;

@end
