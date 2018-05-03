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
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont systemFontOfSize:LyricsFontSize];
        self.selected = NO;
    }
    return self;
}

@end
