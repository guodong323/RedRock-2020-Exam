//
//  bannerCollectionViewCell.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "bannerCollectionViewCell.h"
#import <Masonry.h>

@implementation bannerCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.musicIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:self.musicIcon];
        
        self.songName=[[UILabel alloc]init];
        [self.contentView addSubview:self.songName];
        
        self.artist = [[UILabel alloc] init];
        [self.contentView addSubview:self.artist];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //专辑封面
    [_musicIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@180);
    }];

    //专辑名
    [_songName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@190);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
    _songName.textAlignment = NSTextAlignmentCenter;
    
    //歌手
    [_artist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
    _artist.textAlignment = NSTextAlignmentCenter;
    
}
@end
