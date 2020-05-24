//
//  AppDelegate.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //实例化一个window，并且给了大小和范围
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
       
       
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc]init]];
       
    [self.window makeKeyAndVisible];
    [NSThread sleepForTimeInterval:1];
    return YES;
}



@end
