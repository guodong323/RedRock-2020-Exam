//
//  MysongTableViewCell.h
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MysongTableViewCell : UITableViewCell

//封面
@property(nonatomic,strong) UIImageView *musicIcon;
//歌曲名
@property(nonatomic,strong) UILabel *songName;
//次数
@property(nonatomic,strong) UILabel *count;

@end

NS_ASSUME_NONNULL_END
