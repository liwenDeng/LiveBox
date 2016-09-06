//
//  MSBasePlayerView.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBasePlayerView.h"
#import "IJKMediaFramework/IJKMediaFramework.h"
#import "MSPlayerToolView.h"

@interface MSBasePlayerView () <MSPlayerNomalSizeToolViewDelegate,MSPlayerFullScreenSizeToolViewDelegate>

// IJKKMedia
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) id <IJKMediaPlayback> IJKPlayer;
@property (nonatomic, weak) UIView *IJKMediaPlayerView;

//toolView
@property (nonatomic, strong) MSPlayerNomalSizeToolView *nomalToolView;
@property (nonatomic, strong) MSPlayerFullScreenSizeToolView *fullToolView;

@end

@implementation MSBasePlayerView

- (void)dealloc {
    [self.IJKPlayer stop];
    [self.IJKPlayer shutdown];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        self.rotateState = PlayerViewRotateNomalSize;
        self.lockState = PlayerViewUnLocked;
    }
    return self;
}

- (void)setupSubViews {
    //toolview
    self.nomalToolView = ({
        MSPlayerNomalSizeToolView *view = [[MSPlayerNomalSizeToolView alloc]init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        view.delegate = self;
        view;
    });
    
    
    self.fullToolView = ({
        MSPlayerFullScreenSizeToolView *view = [[MSPlayerFullScreenSizeToolView alloc]init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        view.delegate = self;
        view;
    });
    
    self.fullToolView.hidden = YES;
    self.nomalToolView.hidden = NO;
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playerViewTaped:)];
    [self addGestureRecognizer:tap];
}

- (void)playWithVideoSrc:(NSString *)src {
    [self setupIJKPlayerWithVideoSrc:src];
}

- (void)layoutSubviews {
    self.IJKMediaPlayerView.frame = self.bounds;

}

- (void)setupIJKPlayerWithVideoSrc:(NSString *)src {
    
    if (self.IJKPlayer) {
        [self.IJKPlayer pause];
        [self.IJKPlayer shutdown];
        self.IJKPlayer = nil;
        [self.IJKMediaPlayerView removeFromSuperview];
    }
    self.url = [NSURL URLWithString:src];
    self.IJKPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];
    self.IJKPlayer.scalingMode = IJKMPMovieScalingModeAspectFit;
    
    self.IJKMediaPlayerView = [self.IJKPlayer view];
    self.IJKMediaPlayerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.IJKMediaPlayerView.frame = self.bounds;
    
    [self insertSubview:self.IJKMediaPlayerView belowSubview:self.nomalToolView];
    
    [self.IJKPlayer setScalingMode:IJKMPMovieScalingModeAspectFill];
    if (![self.IJKPlayer isPlaying]) {
        [self.IJKPlayer prepareToPlay];
    }
}

- (void)playerViewTaped:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.rotateState == PlayerViewRotateFullScreenSize) {
            self.fullToolView.hidden = !self.fullToolView.hidden;
        }else {
            self.nomalToolView.hidden = !self.nomalToolView.hidden;
        }
    }
}

- (void)showNomalToolView:(BOOL)show {
    [self.nomalToolView setHidden:!show];
    [self.fullToolView setHidden:show];
    self.rotateState = show ? PlayerViewRotateNomalSize : PlayerViewRotateFullScreenSize;
}

#pragma mark - MSPlayerNomalSizeToolViewDelegate
- (void)normalToolView:(MSPlayerNomalSizeToolView *)toolView willPlay:(BOOL)willPlay {
    willPlay ? [self.IJKPlayer play] : [self.IJKPlayer pause];
}

- (void)normalToolViewClickedBackBtn:(MSPlayerNomalSizeToolView *)toolView {
    if ([self.delegate respondsToSelector:@selector(playerViewBackButtonClicked:)]) {
        [self.delegate playerViewBackButtonClicked:self];
    }
}

- (void)normalToolViewClickedFullScreenBtn:(MSPlayerNomalSizeToolView *)toolView {
    if (self.rotateState == PlayerViewRotateNomalSize) {
        self.rotateState = PlayerViewRotateFullScreenSize;
        self.nomalToolView.hidden = YES;
        self.fullToolView.hidden = NO;
    }else {
        self.rotateState = PlayerViewRotateNomalSize;
    }
    if ([self.delegate respondsToSelector:@selector(playerView:rotateState:)]) {
        [self.delegate playerView:self rotateState:self.rotateState];
    }
}

#pragma mark - MSPlayerFullScreenSizeToolViewDelegate
- (void)fullSizeToolViewClickedRefreshBtn:(MSPlayerFullScreenSizeToolView *)toolView {
    if ([self.delegate respondsToSelector:@selector(playerViewRefreshButtonClicked:)]) {
        [self.delegate playerViewRefreshButtonClicked:self];
    }
}

- (void)fullSizeToolView:(MSPlayerFullScreenSizeToolView *)toolView willPlay:(BOOL)willPlay {
    willPlay ? [self.IJKPlayer play] : [self.IJKPlayer pause];
}

- (void)fullSizeToolViewClickedBackBtn:(MSPlayerFullScreenSizeToolView *)toolView {
    if (self.rotateState == PlayerViewRotateFullScreenSize) {
        self.rotateState = PlayerViewRotateNomalSize;
        self.nomalToolView.hidden = NO;
        self.fullToolView.hidden = YES;
    }else {
        self.rotateState = PlayerViewRotateNomalSize;
    }
    if ([self.delegate respondsToSelector:@selector(playerView:rotateState:)]) {
        [self.delegate playerView:self rotateState:self.rotateState];
    }
}


@end
