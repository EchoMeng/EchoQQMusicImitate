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
    [self.singerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(SingerImageTopMargin);
    }];
    
    [self.singerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(SingerImageLeftRightMargin);
        make.right.mas_equalTo(self.mas_right).offset(-SingerImageLeftRightMargin);
        make.top.mas_equalTo(self.singerLabel.mas_bottom).offset(SingerImageTopMargin);
        make.height.mas_equalTo(self.singerImageView.mas_width);
    }];
    [self.lyricLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.singerImageView.mas_bottom).offset(20);
    }];
}

- (void)setMusic:(MXMusic *)music {
    if (music) {
        self.singerImageView.image = [UIImage imageNamed:music.image];
        self.singerLabel.text = music.singer;
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
        _lyricLabel = [[MXColorLabel alloc] init];
        _lyricLabel.textAlignment = NSTextAlignmentCenter;
        _lyricLabel.textColor = [UIColor whiteColor];
        [self addSubview:_lyricLabel];
    }
    return _lyricLabel;
}

- (UILabel *)singerLabel {
    if (!_singerLabel) {
        _singerLabel = [[UILabel alloc] init];
        _singerLabel.textColor = [UIColor whiteColor];
        [self addSubview:_singerLabel];
    }
    return _singerLabel;
}

@end
