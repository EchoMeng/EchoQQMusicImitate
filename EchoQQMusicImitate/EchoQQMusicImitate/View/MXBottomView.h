//
//  MXBottomView.h
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXMusic.h"

@protocol MXControlDelegate<NSObject>

- (void)playOrPauseMusic:(UIButton *)btn;

- (void)nextMusic;

- (void)lastMusic;

- (void)changeProgress:(CGFloat)progress;

@end

@interface MXBottomView : UIView

@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) UIButton *lastButton;

@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) UISlider *progressSlider;

@property (nonatomic, strong) UILabel *beginTimeLabel;

@property (nonatomic, strong) UILabel *allTimeLabel;

@property (nonatomic, strong) MXMusic *music;

@property (nonatomic, weak) id<MXControlDelegate> delegate;

@end
