//
//  MysongViewController.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

/**
 我的歌单方面
 */
#import "MysongViewController.h"
#import "MysongTableViewCell.h"
#import <AFNetworking.h>
#import "MusicModel.h"
#import "UIImageView+WebCache.h"

@interface MysongViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *listarr;
}

@property(nonatomic,strong) MusicModel *currentModel;
@property(nonatomic,strong) UITableView *songTableView;


@end

@implementation MysongViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    listarr = [NSMutableArray new];
    [self getCase];
    
}

- (void) setUI {
    _songTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _songTableView.delegate = self;
    _songTableView.dataSource = self;
    [self.view addSubview:_songTableView];
}

/**
 发送网络请求
 */
- (void)getCase
{
    NSString *urlStr = @"http://47.99.165.194/user/playlist?uid=403808983&limit=20";
//    对URL中的汉字进行编码,并且去掉空格等无效字符
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
//    创建单例对象(网络管理者）
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /**
         从json数据中拿到自己想要的，这里因为能力有限，挑了三个好展示的数据（有的键看不懂什么意思）
        */
         for (NSDictionary *dic in responseObject[@"playlist"]) {
             MusicModel *model  = [MusicModel new];
             model.name = [dic objectForKey:@"name"];
             model.count = [dic objectForKey:@"playCount"];
             model.icon = [dic objectForKey:@"coverImgUrl"];
             [self->listarr addObject:model];
         }
        //异步刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新数据
            [self.songTableView reloadData];
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
}

#pragma mark- 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self->listarr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  160;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      //创建单元格（用复用池）
      NSString *ID = @"Setting_cell";
      MysongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
      if(cell == nil){
          cell = [[MysongTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
      }
    
    MusicModel *model = listarr[indexPath.row];
    cell.songName.text = model.name;
    
    /**
     这里是个大大大大大大坑，这个数字不能用NSString，直接用NSNumber打印也不行，醉了
     */
    cell.count.text = [NSString stringWithFormat:@"%@%@", @"被播放次数:",model.count];
    
    [cell.musicIcon sd_setImageWithURL:[listarr[indexPath.row]icon]];
    
    return cell;
}



@end
