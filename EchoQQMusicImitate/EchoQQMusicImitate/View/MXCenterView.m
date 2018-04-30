//
//  MXCenterView.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXCenterView.h"

#define SingerImageLeftRightMargin (30)
#define SingerImageTopMargin (30)
#define LyricsLabelBottomMargin (50)

@implementation MXCenterView

- (instancetype)init {
    if (self = [super init]) {
        [self makeUpMarsonry];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.singerImageView.layer.cornerRadius = self.singerImageView.bounds.size.width * .5;
    self.singerImageView.layer.masksToBounds = YES;
}

- (void)makeUpMarsonry {
    [self.singerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(SingerImageLeftRightMargin);
        make.right.mas_equalTo(self.mas_right).offset(-SingerImageLeftRightMargin);
        make.top.mas_equalTo(self.mas_top).offset(SingerImageTopMargin);
        make.height.mas_equalTo(self.singerImageView.mas_width);
    }];
    
    [self.lyricLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-LyricsLabelBottomMargin);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}

- (void)setMusic:(MXMusic *)music {
    if (music) {
        self.singerImageView.image = [UIImage imageNamed:music.image];
        self.lyricLabel.text = music.lrc;
        _music = music;
    }
}

#pragma setter and getter
- (UIImageView *)singerImageView {
    if (!_singerImageView) {
        _singerImageView = [[UIImageView alloc] init];
        [self addSubview:_singerImageView];
    }
    return _singerImageView;
}

- (UILabel *)lyricLabel {
    if (!_lyricLabel) {
        _lyricLabel = [[UILabel alloc] init];
        _lyricLabel.textAlignment = NSTextAlignmentCenter;
        _lyricLabel.textColor = [UIColor whiteColor];
        [self addSubview:_lyricLabel];
    }
    return _lyricLabel;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 3;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

@end
