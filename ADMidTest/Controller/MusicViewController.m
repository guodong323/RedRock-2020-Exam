//
//  MusicViewController.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//
/**
 音乐播放界面
 */
#import "MusicViewController.h"
#import <Masonry.h>
#include "PlayModel.h"
#import "UIImageView+WebCache.h"
#import <AFNetworking.h>

@interface MusicViewController () {
    NSMutableArray *songArray;
}


//缓存音乐图片
@property(nonatomic,strong) NSMutableDictionary *musicImageDic;

//当前播放的音乐模型
@property(nonatomic,strong) PlayModel *currentModel;

//没用上，搞不好😭
//当前歌曲进度监听者
@property(nonatomic,strong) id timeObserver;



@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setPlayer];
    songArray = [[NSMutableArray alloc] init];
    [self getCaseSong];
    [self getSongUrl];
}

- (void)setPlayer {
    //设置播放器代理，后面要使用播放完毕的行为
    player.delegate = self;
    //设定当前音量
    player.volume = 0.2;
    //歌曲总播放时间 player.duration
    //已经播放时间 player.deviceCurrentTime
    //创建定时器，以便及时得到当前播放位置
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

//进度条的位置
- (void)onTimer {
    //进度条的时间 = 播放器当前的时间
    self.playSlider.value = player.currentTime;
}

//设置UI
- (void)setUI {
    //歌曲图片
    _musicIcon = [[UIImageView alloc] init];
    [self.view addSubview:_musicIcon];
    [_musicIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@300);
        make.height.equalTo(@300);
        make.left.mas_equalTo(self.view.frame.size.width/2-150);
        make.top.equalTo(@100);
    }];
    
    //歌曲名
    _musicName =  [[UILabel alloc] init];
    [self.view addSubview:_musicName];
    [_musicName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@300);
        make.height.equalTo(@30);
        make.top.equalTo(@420);
        make.left.mas_equalTo(self.view.frame.size.width/2 - 150);
    }];
    _musicName.textAlignment = NSTextAlignmentCenter;
    
    
    //歌手
    _artist = [[UILabel alloc] init];
    [self.view addSubview:_artist];
    [_artist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        make.top.equalTo(@450);
        make.left.mas_equalTo(self.view.frame.size.width/2 - 50);
    }];
    _artist.textAlignment = NSTextAlignmentCenter;
    
    //进度条
    _playSlider = [[UISlider alloc] init];
    [self.view addSubview:_playSlider];
    [_playSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@260);
        make.left.mas_equalTo(self.view.frame.size.width/2-130);
        make.top.equalTo(@600);
    }];
    [_playSlider addTarget:self action:@selector(progressChanged) forControlEvents:UIControlEventValueChanged];
    
    //当前播放时间
    _currentTime = [[UILabel alloc] init];
    [self.view addSubview:_currentTime];
    [_currentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@25);
        make.left.equalTo(@12);
        make.top.equalTo(@600);
    }];
    
    //这个没搞出来，自己固定一个，意思一下，代表我有这个想法
    _currentTime.text = @"01:23";
    _currentTime.textAlignment = NSTextAlignmentCenter;
    
    //总时长
    _duration = [[UILabel alloc] init];
    [self.view addSubview:_duration];
    [_duration mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.equalTo(@60);
           make.height.equalTo(@25);
           make.right.equalTo(@-12);
           make.top.equalTo(@600);
       }];
    _duration.textAlignment = NSTextAlignmentCenter;

    //下一首
    _nextSong = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_nextSong];
    [_nextSong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.right.equalTo(@-50);
        make.top.equalTo(@680);
    }];
    [_nextSong setImage:[UIImage imageNamed:@"hou.png"] forState:UIControlStateNormal];
    [_nextSong addTarget:self action:@selector(NextSong) forControlEvents:UIControlEventTouchUpInside];
    
    //前一首
    _preSong = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_preSong];
    [_preSong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.left.equalTo(@50);
        make.top.equalTo(@680);
    }];
    [_preSong setImage:[UIImage imageNamed:@"qian.png"] forState:UIControlStateNormal];
    [_preSong addTarget:self action:@selector(PreSong) forControlEvents:UIControlEventTouchUpInside];
    
    //播放/暂停
    _playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_playBtn];
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.left.mas_equalTo(self.view.frame.size.width/2-15);
        make.top.equalTo(@680);
    }];
    if (flag) {
        [_playBtn setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    }else {
        [_playBtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
    [_playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
}

//上一曲
- (void)PreSong {
    //特判
    if (current == 0) {
        return;
    }
    else {
        //当前播放的歌-1
        current --;
    }
    //播放器播放的歌曲
    player = [[AVAudioPlayer alloc] initWithData:self->songArray[current] error:nil];
    //音乐图片
    _musicIcon.image = [UIImage imageNamed:songArray[current]];
    [self startToPlay];
    [self.playBtn setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    flag = YES;
    [self startToPlay];
}

//下一曲
- (void)NextSong {
    if (current == self->songArray.count-1) {
           return;
       }
       else {
           current ++;
       }
    player = [[AVAudioPlayer alloc] initWithData:self->songArray[current] error:nil];
    _musicIcon.image = [UIImage imageNamed:songArray[current]];
       //设置进度条的最大最小值
       [self startToPlay];
       [self.playBtn setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
       flag = YES;
    [self startToPlay];
}

//调整进度条
- (void)progressChanged {
    player.currentTime = _playSlider.value;
}

//是否播放结束
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self.playBtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    flag = NO;
}

//播放与暂停
- (void)play {
    if (!flag) {
        [self startToPlay];
        [_playBtn setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        flag = YES;
    }
    else {
        [player stop];
        [_playBtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        flag = NO;
    }
}

//播放的相关操作
- (void)startToPlay {
    //设置进度条的最大值和最小值
    self.playSlider.maximumValue = player.duration;
    self.playSlider.minimumValue = 0;
    //播放
    [player prepareToPlay];
    [player play];
}

//将模型的数据加载到控件上
-(void)reloadUI:(PlayModel*)model {
    self.musicName.text = model.musicName;
    self.artist.text = model.artist;
    [self.musicIcon sd_setImageWithURL:[NSURL URLWithString:model.musicIcon]];
    self.duration.text = [self getMinuteSecondWithTime:model.duration];
    //这里想要获得现在放了多少秒，失败了
//    self.currentTime.text = player.currentTime;
    self.playBtn.selected = YES;
    self.playSlider.value = 0;
}

//因为AVAudioPlayer只能从本地的资源来放，之前还看到了AVPlayer，不过也没去了解
//通过url保存在本地，再播放音乐
- (void) PlayMusicWithUrl:(PlayModel *)model {
    //先获得json里的URL
    NSString *urlStr = model.musicUrl;
    
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
    NSData * audioData = [NSData dataWithContentsOfURL:url];
    
    //放到本地
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //从本地再取出来
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"temp"];
    [audioData writeToFile:filePath atomically:YES];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    
}



//显示的时间的转化
//这里拿的数据要先%100，醉了，我以为json里的单位是s，搞半天。
-(NSString *)getMinuteSecondWithTime:(NSNumber *)time
{
    int t = [time intValue] / 1000;
    int minute = t / 60;
    int second = (t - minute * 60);
    
    if (second > 9)
    {

        return [NSString stringWithFormat:@"%.2d:%.2d",minute,second];

    }
    return [NSString stringWithFormat:@"%.2d:0%.1d",minute,second];

}

- (void)getCaseSong {
    NSString *urlStr = @"http://47.99.165.194/song/detail?ids=28636039";
    //    对URL中的汉字进行编码,并且去掉空格等无效字符
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        
    //    创建单例对象(网络管理者）
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
            //因为我要展示的东西不多，就直接从 responseObject 里面取了
            //我想取出专辑名，可是json数据是字典套数组套字典，搞的我脑瓜子嗡嗡的
             for (NSDictionary *dic in responseObject[@"songs"]) {
                 self->_currentModel  = [PlayModel new];
                 self->_currentModel.musicName = [dic objectForKey:@"name"];
                 self->_currentModel.duration = [dic objectForKey:@"dt"];
                 NSDictionary *dal = dic[@"al"];
                 self->_currentModel .musicIcon = [dal objectForKey:@"picUrl"];
                 [self->songArray addObject:self->_currentModel];
             }

            //异步刷新数据
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新数据
                [self reloadUI:self->_currentModel];
            });

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
            
        }];
}

//获取歌曲的URL
- (void)getSongUrl {
    NSString *urlStr = @"http://47.99.165.194/song/url?id=28636039&br=320000";
    //    对URL中的汉字进行编码,并且去掉空格等无效字符
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        
    //    创建单例对象(网络管理者）
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
             for (NSDictionary *dic in responseObject[@"data"]) {
                 self->_currentModel  = [PlayModel new];
                 self->_currentModel.musicUrl = [dic objectForKey:@"url"];
                 [self->songArray addObject:self->_currentModel];
                 //NSLog(@"%@",self->_currentModel.musicUrl);
             }
            
            //这样具慢，吐了
           [self PlayMusicWithUrl:self->_currentModel];
            
            //异步加载URL（bug：这样图片和别的就不显示了）
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self PlayMusicWithUrl:self->_currentModel];
//            });

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
        }];
    
}
@end

