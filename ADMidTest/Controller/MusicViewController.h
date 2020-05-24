//
//  MusicViewController.h
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface MusicViewController : UIViewController  <AVAudioPlayerDelegate>{
    //播放器
    AVAudioPlayer *player;
    //当前播放歌曲的号码 从0开始
    int current;
    //播放按钮标识 区分按钮状态
    BOOL flag;
}

//音乐名
@property (strong, nonatomic) UILabel *musicName;
//演唱者
@property (strong, nonatomic) UILabel *artist;
//音乐图片
@property (strong, nonatomic) UIImageView *musicIcon;
//当前播放时间
@property (strong, nonatomic) UILabel *currentTime;
//音乐时常
@property (strong, nonatomic) UILabel *duration;
//播放按钮
@property (strong, nonatomic) UIButton *playBtn;
//播放进度滑块
@property (strong, nonatomic) UISlider *playSlider;
//下一曲
@property (strong, nonatomic) UIButton *nextSong;
//上一曲
@property (strong, nonatomic) UIButton *preSong;

@property (strong, nonatomic) NSString *musicUrl;
@end


