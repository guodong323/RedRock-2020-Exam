//
//  MysongTableViewCell.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "MysongTableViewCell.h"
#import <Masonry.h>

/**
 自定义的cell
 */

@implementation MysongTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        _musicIcon = icon;
            
        UILabel *labTitle = [[UILabel alloc] init];
        [self.contentView addSubview:labTitle];
        _songName = labTitle;
                
        UILabel *labDetail = [[UILabel alloc] init];
        [self.contentView addSubview:labDetail];
        _count = labDetail;
                
        [self setFrame];
    }
    return self;
}

- (void) setFrame {
    //图片
    [_musicIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];
    //歌曲名
    [_songName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@170);
        make.width.mas_equalTo(self.contentView.frame.size.width - 60);
        make.height.equalTo(@30);
    }];
    //不知道这个是bug还是什么，不管用，👴服了
    //换行
    _songName.numberOfLines = 0;
    
    //播放次数
    [_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@90);
        make.left.equalTo(@180);
        make.width.mas_equalTo(self.contentView.frame.size.width - 100);
        make.height.equalTo(@30);
    }];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
