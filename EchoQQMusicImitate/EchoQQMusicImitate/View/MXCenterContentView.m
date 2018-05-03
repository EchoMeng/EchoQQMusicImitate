//
//  MXCenterContentView.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXCenterContentView.h"

@interface MXCenterContentView()

@end

@implementation MXCenterContentView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

#pragma getter and setter
- (MXCenterView *)centerHomeView {
    if (!_centerHomeView) {
        _centerHomeView = [[MXCenterView alloc] init];
        _centerHomeView.frame = CGRectMake(MXScreenWidth, 0, MXScreenWidth, MXScreenHeight - TopHeight - BottomHeight);
        [self addSubview:_centerHomeView];
    }
    return _centerHomeView;
}

- (MXCenterRecommendView *)recommendView {
    if (!_recommendView) {
        _recommendView = [[MXCenterRecommendView alloc] init];
        _recommendView.frame = CGRectMake(0, 0, MXScreenWidth, MXScreenHeight - TopHeight - BottomHeight);
        [self addSubview:_recommendView];
    }
    return _recommendView;
}

- (MXCenterLyricsView *)lyricsView {
    if (!_lyricsView) {
        _lyricsView = [[MXCenterLyricsView alloc] init];
        _lyricsView.frame = CGRectMake(2*MXScreenWidth, 0, MXScreenWidth, MXScreenHeight - TopHeight - BottomHeight);
        [self addSubview:_lyricsView];
    }
    return _lyricsView;
}

@end
