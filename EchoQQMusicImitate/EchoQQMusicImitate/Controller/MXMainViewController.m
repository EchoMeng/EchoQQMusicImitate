//
//  MXMainViewController.m
//  EchoQQMusicImitate
//
//  Created by mac on 2018/4/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MXMainViewController.h"

@interface MXMainViewController ()

@end

@implementation MXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.title = @"QQ音乐";
    [self configBackgroundView];
    
}

- (void)configBackgroundView {
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.frame = self.view.frame;
    backImageView.image = [UIImage imageNamed:@"bg_login"];
    [self.view addSubview:backImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
