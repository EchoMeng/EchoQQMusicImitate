//
//  MXTopView.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXTopView.h"


@implementation MXTopView
- (instancetype)init {
    if (self = [super init]) {
        [self makeUpMasonry];
    }
    return self;
}

- (void)makeUpMasonry {
    [self.singerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

- (void)setMusic:(MXMusic *)music {
    if (music) {
        self.singerLabel.text = music.singer;
        _music = music;
    }
}

#pragma getter and setter
- (UILabel *)singerLabel {
    if (!_singerLabel) {
        _singerLabel = [[UILabel alloc] init];
        _singerLabel.textColor = [UIColor whiteColor];
        [self addSubview:_singerLabel];
    }
    return _singerLabel;
}

@end
