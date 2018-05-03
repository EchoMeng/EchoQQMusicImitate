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
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

#pragma getter and setter

- (MXCenterContentView *)centerContentView {
    if (!_centerContentView) {
        _centerContentView = [[MXCenterContentView alloc] init];
        _centerContentView.frame = CGRectMake(0, 0, MXScreenWidth * 3, self.superview.bounds.size.height);
        [self addSubview:_centerContentView];
    }
    return _centerContentView;
}

@end
