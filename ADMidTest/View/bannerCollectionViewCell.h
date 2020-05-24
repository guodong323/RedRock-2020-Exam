//
//  bannerCollectionViewCell.h
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface bannerCollectionViewCell : UICollectionViewCell

//专辑封面
@property(nonatomic,strong)UIImageView *musicIcon;

//专辑名
@property(nonatomic,strong)UILabel *songName;

//歌手
@property(nonatomic,strong)UILabel *artist;

@end


