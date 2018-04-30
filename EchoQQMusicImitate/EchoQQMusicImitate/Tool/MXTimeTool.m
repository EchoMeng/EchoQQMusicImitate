//
//  MXTimeTool.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXTimeTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation MXTimeTool

+ (NSString *)timeStringFromTimeInterval:(NSTimeInterval)time {
    int min = time / 60;
    int sec = (int)time % 60;
    NSString *minStr;
    NSString *secStr;
    if (min >= 10) {
        minStr = [NSString stringWithFormat:@"%d", min];
    } else {
        minStr = [NSString stringWithFormat:@"0%d", min];
    }
    if (sec >= 10) {
        secStr = [NSString stringWithFormat:@"%d", sec];
    } else {
        secStr = [NSString stringWithFormat:@"0%d", sec];
    }
    NSString *timeStr = [NSString stringWithFormat:@"%@:%@", minStr,secStr];
    return timeStr;
}

+ (NSString *)timeStringFromMusicFile:(NSString *)fileName {
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    return [self timeStringFromTimeInterval:player.duration];
}


@end
