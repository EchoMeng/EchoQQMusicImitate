//
//  MXColorLabel.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXColorLabel.h"

@implementation MXColorLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self.progressColor set];
    rect.size.width *= _progress;
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}

#pragma getter and setter
- (UIColor *)progressColor {
    if (!_progressColor) {
        _progressColor = [UIColor greenColor];
    }
    return _progressColor;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}
@end
