//
//  MXMainViewController.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXMainViewController.h"
#import "MXTopView.h"
#import "MXCenterScrollView.h"
#import "MXBottomView.h"
#import "MXMusic.h"
#import <MJExtension.h>
#import "MXPlayManager.h"
#import "MXTimeTool.h"
#import "MXLyricsPhaser.h"
#import "MXLyrics.h"

@interface MXMainViewController () <MXControlDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *singerBackgrundView;

@property (nonatomic, strong) MXTopView *topView;

@property (nonatomic, strong) MXCenterScrollView *centerScrollView;

@property (nonatomic, strong) MXBottomView *bottomView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger currentMusic;

@property (nonatomic, strong) MXMusic *currentMusicModel;

@property (nonatomic, strong) MXPlayManager *playManager;

@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *lyrics;

@property (nonatomic, assign) NSInteger currentLyricsIndex;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation MXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configBackgroundView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.centerScrollView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.pageControl];
    [self makeUpMarsonry];
    [self upLoadData];
}

- (void)upLoadData {
    if (self.currentMusic >= self.dataArray.count) {
        self.currentMusic = 0;
    }
    _currentMusicModel = self.dataArray[self.currentMusic];
    self.singerBackgrundView.image = [UIImage imageNamed:_currentMusicModel.image];
    _lyrics = [MXLyricsPhaser lyricsWithFileName:_currentMusicModel.lrc];
    self.currentLyricsIndex = 0;
    self.title = _currentMusicModel.name;
    self.topView.music = _currentMusicModel;
    self.centerScrollView.centerContentView.centerHomeView.music = _currentMusicModel;
    self.bottomView.music = _currentMusicModel;
    if (self.playManager.allTime == 0) {
        self.bottomView.allTimeLabel.text = [MXTimeTool timeStringFromMusicFile:_currentMusicModel.mp3];
    } else {
        self.bottomView.allTimeLabel.text = [MXTimeTool timeStringFromTimeInterval:self.playManager.allTime];
    }
    self.bottomView.beginTimeLabel.text = [MXTimeTool timeStringFromTimeInterval:self.playManager.currentTime];
}

- (void)updateLyrics {
    MXLyrics *currentLyric = self.lyrics[self.currentLyricsIndex];
    MXLyrics *nextLyrics = [self nextLyrics];
    //播放时间大于等于下一句歌词对应时间，显示歌词应该更新到下一句
    if (self.playManager.currentTime >= nextLyrics.initTime && self.currentLyricsIndex < self.lyrics.count - 1) {
        self.currentLyricsIndex++;
        currentLyric = self.lyrics[self.currentLyricsIndex];
        self.centerScrollView.centerContentView.centerHomeView.lyricLabel.text = currentLyric.content;
    }
    if (self.playManager.currentTime < currentLyric.initTime && self.currentLyricsIndex != 0) {
        self.currentLyricsIndex--;
        currentLyric = self.lyrics[self.currentLyricsIndex];
        self.centerScrollView.centerContentView.centerHomeView.lyricLabel.text = currentLyric.content;
    }
    nextLyrics = [self nextLyrics];
    //更新歌词的渲染颜色
    CGFloat progress = (self.playManager.currentTime - currentLyric.initTime) / (nextLyrics.initTime - currentLyric.initTime);
    self.centerScrollView.centerContentView.centerHomeView.lyricLabel.progress = progress;
}

- (MXLyrics *)nextLyrics {
    MXLyrics *currentLyric = self.lyrics[self.currentLyricsIndex];
    MXLyrics *nextLyrics = nil;
    if (self.currentLyricsIndex == self.lyrics.count - 1) {
        nextLyrics = currentLyric;
    } else {
        nextLyrics = self.lyrics[self.currentLyricsIndex + 1];
    }
    return nextLyrics;
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
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-BottomHeight);
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
    self.centerScrollView.centerContentView.centerHomeView.singerImageView.transform = CGAffineTransformRotate(self.centerScrollView.centerContentView.centerHomeView.singerImageView.transform, angle);
    //时间显示更新
    self.bottomView.beginTimeLabel.text = [MXTimeTool timeStringFromTimeInterval:self.playManager.currentTime];
    //歌词更新
    [self updateLyrics];
}

- (void)pageChange {
    NSInteger page = self.pageControl.currentPage;
    self.centerScrollView.contentOffset = CGPointMake(MXScreenWidth * page, 0);
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

#pragma tableview datasaurce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"推荐一首";
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma scrollviewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / MXScreenWidth;
    self.pageControl.currentPage = page;
}


#pragma getter and setter
- (MXTopView *)topView {
    if (!_topView) {
        _topView = [[MXTopView alloc] init];
    }
    return _topView;
}

- (MXCenterScrollView *)centerScrollView {
    if (!_centerScrollView) {
        _centerScrollView = [[MXCenterScrollView alloc] init];
        _centerScrollView.contentSize = CGSizeMake(3 * MXScreenWidth, 0);
        _centerScrollView.pagingEnabled = YES;
        _centerScrollView.delegate = self;
        _centerScrollView.centerContentView.lyricsView.delegate = self;
        _centerScrollView.centerContentView.lyricsView.dataSource = self;
        _centerScrollView.centerContentView.recommendView.delegate = self;
        _centerScrollView.centerContentView.recommendView.dataSource = self;
        _centerScrollView.frame = CGRectMake(0, TopHeight, MXScreenWidth, MXScreenHeight - TopHeight - BottomHeight);
    }
    return _centerScrollView;
}

- (MXBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[MXBottomView alloc] init];
        _bottomView.delegate = self;
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

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 3;
        [_pageControl addTarget:self action:@selector(pageChange) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

@end
