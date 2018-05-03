//
//  MXCenterRecommendView.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXCenterRecommendView.h"

@implementation MXCenterRecommendView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}


@end
