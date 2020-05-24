//
//  bannerViewController.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "bannerViewController.h"
#import "bannerModel.h"
#import "bannerCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import <AFNetworking.h>

@interface bannerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    NSMutableArray *bannerlist;
}
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation bannerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    bannerlist = [NSMutableArray new];
    [self getCase];
    [self setUI];
}

- (void)setUI {
    //创建UICollectionViewFlowLayout，使用系统默认流式布局，或者自定义布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 10) / 2, 300);
    
    //创建UICollectionView，设置delegate和datasource，注册cell类型
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    //选择实现UICollectionViewDataSource中方法，行数，cell复用
    //选择实现UICollectionViewDelegate中方法（点击，滚动等）
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[bannerCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:_collectionView];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return bannerlist.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    bannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    bannerModel *model = bannerlist[indexPath.row];
    cell.songName.text = model.songName;
    cell.artist.text = model.artist;
    [cell.musicIcon sd_setImageWithURL:[bannerlist[indexPath.row]picUrl]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        return CGSizeMake((self.view.frame.size.width - 10) / 2, 250);
}

- (void)getCase
{
    NSString *urlStr = @"http://47.99.165.194/album/newest";
//    对URL中的汉字进行编码,并且去掉空格等无效字符
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
//    创建单例对象(网络管理者）
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    for (NSDictionary *dic in responseObject[@"albums"]) {
        bannerModel *model = [[bannerModel alloc] init];
        model.songName = [dic objectForKey:@"name"];
        model.picUrl = [dic objectForKey:@"picUrl"];
        NSDictionary *d = dic[@"artist"];
        model.artist = [d objectForKey:@"name"];
        [self->bannerlist addObject:model];
    }
        //异步刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
}



@end
