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
    [self.playManager playWithContentOfFile:self.currentMusicModel.mp3 didCompletion:^{
        [self nextMusic];
    }];
}

- (void)pauseCurrentMusic {
    [self.playManager.player pause];
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
    if (self.currentMusic >= self.dataArray.count) {
        self.currentMusic = 0;
    }
    [self upLoadData];
    if (self.isPlaying) {
        [self playCurrentMusic];
    }
}

- (void)lastMusic {
    self.currentMusic--;
    if (self.currentMusic < 0) {
        self.currentMusic = self.dataArray.count - 1;
    }
    [self upLoadData];
    if (self.isPlaying) {
        [self playCurrentMusic];
    }
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
