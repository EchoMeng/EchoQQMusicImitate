//
//  MXRecommendTableViewCell.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXRecommendTableViewCell.h"

#define AlbumImageViewMargin (15)
#define MusicNameLeftMargin (20)
#define AlbumLabelLeftMargin (20)
#define SubTextFontSize (15)

@implementation MXRecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selected = NO;
        [self makeUpMasonry];
    }
    return self;
}

- (void)makeUpMasonry {
    [self.albumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(AlbumImageViewMargin);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-AlbumImageViewMargin);
        make.left.mas_equalTo(self.mas_left).offset(AlbumImageViewMargin);
        make.width.mas_equalTo(self.albumImageView.mas_height);
    }];
    [self.musicNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.albumImageView.mas_top);
        make.left.mas_equalTo(self.albumImageView.mas_right).offset(MusicNameLeftMargin);
    }];
    [self.singerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.musicNameLabel.mas_left);
        make.bottom.mas_equalTo(self.albumImageView.mas_bottom);
    }];
    [self.albumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.singerLabel.mas_right).offset(AlbumLabelLeftMargin);
        make.top.mas_equalTo(self.singerLabel.mas_top);
        make.bottom.mas_equalTo(self.singerLabel.mas_bottom);
    }];
}


#pragma getter and setter
- (UIImageView *)albumImageView {
    if (!_albumImageView) {
        _albumImageView = [[UIImageView alloc] init];
        [self addSubview:_albumImageView];
    }
    return _albumImageView;
}

- (UILabel *)musicNameLabel {
    if (!_musicNameLabel) {
        _musicNameLabel = [[UILabel alloc] init];
        _musicNameLabel.textColor = [UIColor whiteColor];
        [self addSubview:_musicNameLabel];
    }
    return _musicNameLabel;
}

- (UILabel *)singerLabel {
    if (!_singerLabel) {
        _singerLabel = [[UILabel alloc] init];
        _singerLabel.textColor = [UIColor whiteColor];
        _singerLabel.font = [UIFont systemFontOfSize:SubTextFontSize];
        [self addSubview:_singerLabel];
    }
    return _singerLabel;
}

- (UILabel *)albumLabel {
    if (!_albumLabel) {
        _albumLabel = [[UILabel alloc] init];
        _albumLabel.textColor = [UIColor whiteColor];
        _albumLabel.font = [UIFont systemFontOfSize:SubTextFontSize];
        [self addSubview:_albumLabel];
    }
    return _albumLabel;
}

@end
