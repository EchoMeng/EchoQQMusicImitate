//
//  MXMainViewController.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXMainViewController.h"
#import "MXTopView.h"
#import "MXCenterView.h"
#import "MXBottomView.h"
#import "MXMusic.h"
#import <MJExtension.h>
#import "MXPlayManager.h"
#import "MXTimeTool.h"

#define TopHeight (124)
#define BottomHeight (140)


@interface MXMainViewController () <MXControlDelegate>

@property (nonatomic, strong) UIImageView *singerBackgrundView;

@property (nonatomic, strong) MXTopView *topView;

@property (nonatomic, strong) MXCenterView *centerView;

@property (nonatomic, strong) MXBottomView *bottomView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger currentMusic;

@property (nonatomic, strong) MXMusic *currentMusicModel;

@property (nonatomic, strong) MXPlayManager *playManager;

@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configBackgroundView];
    [self makeUpMarsonry];
    [self upLoadData];
}

- (void)upLoadData {
    if (self.currentMusic >= self.dataArray.count) {
        self.currentMusic = 0;
    }
    _currentMusicModel = self.dataArray[self.currentMusic];
    self.singerBackgrundView.image = [UIImage imageNamed:_currentMusicModel.image];
    self.title = _currentMusicModel.name;
    self.topView.music = _currentMusicModel;
    self.centerView.music = _currentMusicModel;
    self.bottomView.music = _currentMusicModel;
    if (self.playManager.allTime == 0) {
        self.bottomView.allTimeLabel.text = [MXTimeTool timeStringFromMusicFile:_currentMusicModel.mp3];
    } else {
        self.bottomView.allTimeLabel.text = [MXTimeTool timeStringFromTimeInterval:self.playManager.allTime];
    }
    self.bottomView.beginTimeLabel.text = [MXTimeTool timeStringFromTimeInterval:self.playManager.currentTime];
}

- (void)makeUpMarsonry {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(TopHeight);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(BottomHeight);
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
}

- (void)configBackgroundView {
    //导航栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.title = @"QQ音乐";
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //背景
    _singerBackgrundView = [[UIImageView alloc] init];
    _singerBackgrundView.frame = MXScreenBounds;
    [self.view addSubview:_singerBackgrundView];
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:self.singerBackgrundView.bounds];
    toolBar.barStyle = UIBarStyleBlack;
    [self.singerBackgrundView addSubview:toolBar];
}

- (void)playCurrentMusic {
    self.bottomView.progressSlider.value = 0;
    [self startTimer];
    [self.playManager playWithContentOfFile:self.currentMusicModel.mp3 didCompletion:^{
        self.currentMusic++;
        [self changeMusic];
    }];
}

- (void)pauseCurrentMusic {
    [self.playManager.player pause];
    [self stopTimer];
}

- (void)playProgressChange {
    //进度条更新
    self.bottomView.progressSlider.value = self.playManager.currentTime / self.playManager.allTime * 100;
    //图片旋转
    CGFloat angle = M_PI_4 * .01;
    self.centerView.singerImageView.transform = CGAffineTransformRotate(self.centerView.singerImageView.transform, angle);
    //时间显示更新
    self.bottomView.beginTimeLabel.text = [MXTimeTool timeStringFromTimeInterval:self.playManager.currentTime];
}

#pragma <MXControlDelegate>
- (void)playOrPauseMusic:(UIButton *)btn {
    if (btn.selected) {
        [self playCurrentMusic];
        self.isPlaying = YES;
    } else {
        [self pauseCurrentMusic];
        self.isPlaying = NO;
    }
}

- (void)nextMusic {
    self.currentMusic++;
    [self changeMusic];
}

- (void)lastMusic {
    self.currentMusic--;
    [self changeMusic];
}

- (void)changeMusic {
    [self stopTimer];
    if (self.currentMusic >= self.dataArray.count) {
        self.currentMusic = 0;
    } else if (self.currentMusic < 0) {
        self.currentMusic = self.dataArray.count - 1;
    }
    [self upLoadData];
    if (self.isPlaying) {
        [self playCurrentMusic];
    }
}

- (void)changeProgress:(CGFloat)progress {
    self.playManager.player.currentTime = progress * self.playManager.allTime;
}

#pragma timer
- (void)startTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playProgressChange) userInfo:nil repeats:YES];
}

- (void)stopTimer {
    [self.timer invalidate];
    _timer = nil;
}

#pragma getter and setter
- (MXTopView *)topView {
    if (!_topView) {
        _topView = [[MXTopView alloc] init];
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (MXCenterView *)centerView {
    if (!_centerView) {
        _centerView = [[MXCenterView alloc] init];
        [self.view addSubview:_centerView];
    }
    return _centerView;
}

- (MXBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[MXBottomView alloc] init];
        _bottomView.delegate = self;
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [MXMusic mj_objectArrayWithFilename:@"mlist.plist"];
    }
    return _dataArray;
}

- (NSInteger)currentMusic {
    if (!_currentMusic) {
        _currentMusic = 0;
    }
    return _currentMusic;
}

- (MXPlayManager *)playManager {
    if (!_playManager) {
        _playManager = [MXPlayManager shareManager];
    }
    return _playManager;
}

@end
