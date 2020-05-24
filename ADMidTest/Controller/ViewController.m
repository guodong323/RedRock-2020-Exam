//
//  ViewController.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//
/**
 登陆界面
 */

#import "ViewController.h"
#import "MainViewController.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self ldView];
}

- (void)ldView {
    UIView *view = [[UIView alloc] init];
    UIButton *fbBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton *twBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height/4+50);
    }];
    view.backgroundColor = [UIColor colorWithRed:247/255.0 green:248/255.0 blue:250/255.0 alpha:1.0];
    
    [view addSubview:fbBtn];
    [fbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@300);
        make.height.equalTo(@60);
        make.top.equalTo(@50);
        make.left.mas_equalTo(self.view.frame.size.width/2 - 150);
    }];
    [fbBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle-1"] forState:UIControlStateNormal];
    [fbBtn setTitle:@"Login With Facebook" forState:UIControlStateNormal];

   fbBtn.tintColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [view addSubview:twBtn];
    [twBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@300);
        make.height.equalTo(@60);
        make.top.equalTo(@150);
        make.left.mas_equalTo(self.view.frame.size.width/2 - 150);
    }];
    [twBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle"] forState:UIControlStateNormal];
    [twBtn setTitle:@"Login With Twitter" forState:UIControlStateNormal];
    twBtn.tintColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.frame.size.height/5 * 3);
        make.height.equalTo(@60);
        make.width.equalTo(@300);
        make.left.mas_equalTo(self.view.frame.size.width/2 - 150);
    }];
    btn.backgroundColor = [UIColor redColor];
    btn.layer.cornerRadius = 12;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"登陆" forState:UIControlStateNormal];
    btn.tintColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [btn addTarget:self action:@selector(jumpToMain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UITextField *account = [[UITextField alloc] init];
    UITextField *passWord = [[UITextField alloc] init];
    [self.view addSubview:account];
    [self.view addSubview:passWord];
    
    [account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.frame.size.height / 3 + 50);
        make.width.equalTo(@350);
        make.height.equalTo(@60);
        make.left.mas_equalTo(self.view.frame.size.width/2 - 175);
    }];
    account.backgroundColor = [UIColor lightGrayColor];
    account.placeholder = @"账号";
    account.textAlignment = NSTextAlignmentCenter;
    account.borderStyle = UITextBorderStyleRoundedRect;
    
    [passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.frame.size.height / 3 + 150);
        make.width.equalTo(@350);
        make.height.equalTo(@60);
        make.left.mas_equalTo(self.view.frame.size.width/2 - 175);
    }];
    passWord.backgroundColor = [UIColor lightGrayColor];
    passWord.placeholder = @"密码";
    passWord.textAlignment = NSTextAlignmentCenter;
    passWord.borderStyle = UITextBorderStyleRoundedRect;
    
    UIImageView *type = [[UIImageView alloc] init];
    [self.view addSubview:type];
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.frame.size.height / 7);
        make.width.equalTo(@180);
        make.height.equalTo(@180);
        make.left.mas_equalTo(self.view.frame.size.width/2 - 90);
    }];
    type.image = [UIImage imageNamed:@"樱花"];
    
}


- (void)jumpToMain {
    MainViewController *tabBarCtrl = [[MainViewController alloc]init];
    [self.navigationController pushViewController:tabBarCtrl animated:YES];
}

@end
