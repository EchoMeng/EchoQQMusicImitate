//
//  MXPlayManager.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXPlayManager.h"
@interface MXPlayManager() <AVAudioPlayerDelegate>

@property (nonatomic, strong) NSString *fileName;

@property (nonatomic, copy) void(^complete)(void);

@end


@implementation MXPlayManager


- (void)playWithContentOfFile:(NSString *)fileName didCompletion:(void(^)(void))completion {
    if (![_fileName isEqualToString:fileName]) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _player.delegate = self;
        [_player prepareToPlay];
        _fileName = fileName;
        _complete = completion;
    }
    [_player play];
}


#pragma getter and setter
+ (instancetype)shareManager {
    static MXPlayManager *_manager;
    @synchronized (self) {
        if (_manager == nil) {
            _manager = [[MXPlayManager alloc] init];
        }
    }
    return _manager;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    self.player.currentTime = currentTime;
}

- (NSTimeInterval)currentTime {
    return self.player.currentTime;
}

- (NSTimeInterval)allTime {
    return self.player.duration;
}

#pragma <AVAudioPlayerDelegate>
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        _complete();
    }
}

@end
