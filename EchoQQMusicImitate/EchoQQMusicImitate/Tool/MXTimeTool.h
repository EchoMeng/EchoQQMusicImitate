//
//  MXTimeTool.h
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXTimeTool : NSObject

+ (NSString *)timeStringFromTimeInterval:(NSTimeInterval)time;

+ (NSString *)timeStringFromMusicFile:(NSString *)fileName;

@end
