//
//  MXMusic.h
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXMusic : NSObject

@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *lrc;

@property (nonatomic, strong) NSString *mp3;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *singer;

@property (nonatomic, strong) NSString *album;

@property (nonatomic, assign) NSInteger type;

@end
