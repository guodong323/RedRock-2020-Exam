//
//  MainViewController.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

/**
 主界面
 */

#import "MainViewController.h"
#import "bannerViewController.h"
#import "MysongViewController.h"
#import "MusicViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dismissViewControllerAnimated:NO completion: nil];

    
    MysongViewController *mysongVC = [[MysongViewController alloc] init];
    mysongVC.tabBarItem.title = @"音乐";
    mysongVC.tabBarItem.image = [UIImage imageNamed:@"Library"];
    mysongVC.tabBarItem.selectedImage = [UIImage imageNamed:@"Library-1"];
    [self addChildViewController: mysongVC];
    
    MusicViewController *musicVC = [[MusicViewController alloc] init];
    musicVC.tabBarItem.title = @"音乐";
    musicVC.tabBarItem.image = [UIImage imageNamed:@"Account-1"];
    musicVC.tabBarItem.selectedImage = [UIImage imageNamed:@"Account"];
    [self addChildViewController: musicVC];
    
    bannerViewController *bannerVC = [[bannerViewController alloc] init];
    bannerVC.tabBarItem.title = @"热门";
    bannerVC.tabBarItem.image = [UIImage imageNamed:@"Flame-1"];
    bannerVC.tabBarItem.selectedImage = [UIImage imageNamed:@"Flame"];
    [self addChildViewController:bannerVC];
}


-(void)viewWillAppear:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:YES];
}



@end
