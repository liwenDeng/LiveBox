//
//  MSLiveSteamViewController.m
//  MSLiveBox
//
//  Created by dengliwen on 16/9/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSLiveSteamViewController.h"
#import "MSBasePlayerView.h"

@interface MSLiveSteamViewController () <MSBasePlayerViewDelegate>

@property (nonatomic, strong) MSBasePlayerView *playerView;

@end

@implementation MSLiveSteamViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupPlayerView];
    [self requestRoomVideoSrc];
//    [self setUpScreenControl];
}

/**
 *  播放器的占位图
 */
- (void)setupPlayerView {
    
    self.playerView = [[MSBasePlayerView alloc]init];
    self.playerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.playerView];
    if (self.roomModel.isVertical) {
        [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }else {
        [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.left.width.equalTo(self.view);
            make.height.equalTo(self.playerView.mas_width).multipliedBy(kSCREEN_WIDTH/kSCREENH_HEIGHT);
        }];
    }
    self.playerView.delegate = self;
}

// 获取播放信息
- (void)requestRoomVideoSrc {
    switch (self.roomModel.type) {
        case MSLivetypeDouYu:
        {
            [MSNetworking getDouyuRoomLiveInfo:self.roomModel.roomId success:^(NSDictionary *object) {
                NSString *rtmp_live = object[@"data"][@"rtmp_live"];
                NSString *url = object[@"data"][@"rtmp_url"];
                NSString *src = [NSString stringWithFormat:@"%@/%@",url,rtmp_live];
                NSLog(@"video src:%@",src);
                [self.playerView playWithVideoSrc:src];
            } failure:^(NSError *error) {
                
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - MSRoomPlyaerViewDelegate
- (void)playerView:(MSBasePlayerView *)view rotateState:(PlayerViewRotateState)state {
    self.playerView.backgroundColor = [UIColor grayColor];
    switch (state) {
        case PlayerViewRotateFullScreenSize:
        {
            //http://www.jianshu.com/p/fd7f30de5d42
            NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
            [UIViewController attemptRotationToDeviceOrientation];
        }
            break;
        case PlayerViewRotateNomalSize:
        {
            NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
            [UIViewController attemptRotationToDeviceOrientation];
        }
            break;
    }
}

- (void)playerViewRefreshButtonClicked:(MSBasePlayerView *)view {
    [self requestRoomVideoSrc];
}

- (void)playerViewBackButtonClicked:(MSBasePlayerView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 屏幕旋转时，需要隐藏toolView
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self.playerView showNomalToolView:NO];
    } else {
        [self.playerView showNomalToolView:YES];
    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //当前支持的旋转类型
    if (self.roomModel.isVertical) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    // 是否支持旋转
    if (self.roomModel.isVertical) {
        return NO;
    }
    return YES;
}

@end
