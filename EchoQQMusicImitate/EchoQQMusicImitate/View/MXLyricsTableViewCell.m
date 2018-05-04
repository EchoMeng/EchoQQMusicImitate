//
//  MXLyricsTableViewCell.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXLyricsTableViewCell.h"

#define LyricsFontSize (14)

@implementation MXLyricsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        self.colorLabel.textAlignment = NSTextAlignmentCenter;
        self.colorLabel.textColor = [UIColor whiteColor];
        self.colorLabel.font = [UIFont systemFontOfSize:LyricsFontSize];
        self.selected = NO;
    }
    return self;
}

#pragma setter and getter
- (MXColorLabel *)colorLabel {
    if (!_colorLabel) {
        _colorLabel = [[MXColorLabel alloc] init];
        [self addSubview:_colorLabel];
    }
    return _colorLabel;
}
    

@end
