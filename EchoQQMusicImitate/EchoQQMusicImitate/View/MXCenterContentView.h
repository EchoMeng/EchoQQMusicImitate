//
//  MXCenterContentView.h
//  EchoQQMusicImitate
//
//  Created by mac on 2018/5/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXCenterView.h"
#import "MXCenterLyricsView.h"
#import "MXCenterRecommendView.h"


@interface MXCenterContentView : UIView

@property (nonatomic, strong) MXCenterView *centerHomeView;

@property (nonatomic, strong) MXCenterRecommendView *recommendView;

@property (nonatomic, strong) MXCenterLyricsView *lyricsView;

@end
