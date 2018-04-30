//
//  MXPlayManager.h
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MXPlayManager : NSObject

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, assign) NSTimeInterval currentTime;

@property (nonatomic, assign) NSTimeInterval allTime;

+ (instancetype)shareManager;

- (void)playWithContentOfFile:(NSString *)fileName didCompletion:(void(^)(void))completion;

@end
