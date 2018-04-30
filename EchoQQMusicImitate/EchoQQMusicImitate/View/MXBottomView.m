//
//  MXBottomView.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXBottomView.h"

#define PlayBtnTopMargin (30)
#define PlayBtnWH (100)
#define NextLastWH (70)
#define NextLastLRMargin (0)
#define ProgressMargin (20)
#define TimeLabelWidth (40)
#define ProgressHeight (30)

@implementation MXBottomView

- (instancetype)init {
    if (self = [super init]) {
        [self makeUpMasonry];
    }
    return self;
}

- (void)makeUpMasonry {
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(PlayBtnTopMargin);
//        make.width.and.height.mas_equalTo(PlayBtnWH);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.playButton.mas_centerY);
        make.left.mas_equalTo(self.playButton.mas_right).offset(NextLastLRMargin);
//        make.width.and.height.mas_equalTo(NextLastWH);
    }];
    
    [self.lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.playButton.mas_centerY);
        make.right.mas_equalTo(self.playButton.mas_left).offset(-NextLastLRMargin);
//        make.width.and.height.mas_equalTo(NextLastWH);
    }];
    
    [self.beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ProgressMargin);
        make.top.mas_equalTo(self.mas_top).offset(ProgressMargin);
        make.width.mas_equalTo(TimeLabelWidth);
    }];
    
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.beginTimeLabel.mas_centerY);
        make.left.mas_equalTo(self.beginTimeLabel.mas_right);
        make.height.mas_equalTo(ProgressHeight);
    }];
    
    [self.allTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-ProgressMargin);
        make.top.mas_equalTo(self.mas_top).offset(ProgressMargin);
        make.width.mas_equalTo(TimeLabelWidth);
    }];
}

- (void)setMusic:(MXMusic *)music {
    if (music) {
        _music = music;
    }
}

#pragma control
- (void)playOrPauseClick:(UIButton *)btn {
    btn.selected  = !btn.selected;
    if ([self.delegate respondsToSelector:@selector(playOrPauseMusic:)]) {
        [self.delegate playOrPauseMusic:btn];
    }
}

- (void)nextBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(nextMusic)]) {
        [self.delegate nextMusic];
    }
}

- (void)lastBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(lastMusic)]) {
        [self.delegate lastMusic];
    }
}

#pragma getter and setter
- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        [_playButton setImage:[UIImage imageNamed:@"landscape_player_btn_play_normal"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"landscape_player_btn_play_press"] forState:UIControlStateHighlighted];
        [_playButton setImage:[UIImage imageNamed:@"landscape_player_btn_pause_normal"] forState:UIControlStateSelected];
        [_playButton addTarget:self action:@selector(playOrPauseClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playButton];
    }
    return _playButton;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        [_nextButton setImage:[UIImage imageNamed:@"landscape_player_btn_next_normal"] forState:UIControlStateNormal];
        [_nextButton setImage:[UIImage imageNamed:@"landscape_player_btn_next_press"] forState:UIControlStateHighlighted];
        [_nextButton addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextButton];
    }
    return _nextButton;
}

- (UIButton *)lastButton {
    if (!_lastButton) {
        _lastButton = [[UIButton alloc] init];
        [_lastButton setImage:[UIImage imageNamed:@"landscape_player_btn_pre_normal"] forState:UIControlStateNormal];
        [_lastButton setImage:[UIImage imageNamed:@"landscape_player_btn_pre_press"] forState:UIControlStateHighlighted];
        [_lastButton addTarget:self action:@selector(lastBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_lastButton];
    }
    return _lastButton;
}

- (UISlider *)progressSlider {
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc] init];
        [_progressSlider setThumbImage:[UIImage imageNamed:@"slider15x15"] forState:UIControlStateNormal];
        [_progressSlider setMaximumValue:100];
        [_progressSlider setMinimumValue:0];
        _progressSlider.tintColor = [UIColor colorWithRed:58/255.0 green:193/255.0 blue:126/255.0 alpha:1];
        [self addSubview:_progressSlider];
    }
    return _progressSlider;
}

- (UILabel *)beginTimeLabel {
    if (!_beginTimeLabel) {
        _beginTimeLabel = [[UILabel alloc] init];
        [self addSubview:_beginTimeLabel];
    }
    return _beginTimeLabel;
}

- (UILabel *)allTimeLabel {
    if (!_allTimeLabel) {
        _allTimeLabel = [[UILabel alloc] init];
        [self addSubview:_allTimeLabel];
    }
    return  _allTimeLabel;
}

@end
