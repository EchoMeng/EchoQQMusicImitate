//
//  MXCenterView.h
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXMusic.h"

@interface MXCenterView : UIView

@property (nonatomic, strong) UIImageView *singerImageView;

@property (nonatomic, strong) UILabel *lyricLabel;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) MXMusic *music;

@end
