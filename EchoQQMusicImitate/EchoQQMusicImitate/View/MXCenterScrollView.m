//
//  MXCenterScrollView.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXCenterScrollView.h"

@implementation MXCenterScrollView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

#pragma getter and setter
- (MXCenterView *)centerHomeView {
    if (!_centerHomeView) {
        _centerHomeView = [[MXCenterView alloc] init];
        _centerHomeView.frame = CGRectMake(MXScreenWidth, 0, MXScreenWidth, MXScreenHeight - BottomHeight);
        [self addSubview:_centerHomeView];
    }
    return _centerHomeView;
}

- (MXCenterRecommendView *)recommendView {
    if (!_recommendView) {
        _recommendView = [[MXCenterRecommendView alloc] initWithFrame:CGRectMake(0, 0, MXScreenWidth, MXScreenHeight - BottomHeight) style:UITableViewStylePlain];
        _recommendView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [self addSubview:_recommendView];
    }
    return _recommendView;
}

- (MXCenterLyricsView *)lyricsView {
    if (!_lyricsView) {
        _lyricsView = [[MXCenterLyricsView alloc] initWithFrame:CGRectMake(2*MXScreenWidth, 0, MXScreenWidth, MXScreenHeight - BottomHeight) style:UITableViewStylePlain];
        _lyricsView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_lyricsView];
    }
    return _lyricsView;
}

@end
