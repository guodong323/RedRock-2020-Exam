//
//  MusicModel.h
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

/**
 歌单模型
 */

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject
/**
 歌曲编号
 */
@property(nonatomic,copy)NSNumber *Id;
/**
 歌名
 */
@property(nonatomic,strong) NSString *name;
/**
 被播放次数
 */
@property(nonatomic,strong)NSNumber *count;
/**
 歌曲封面
 */
@property(nonatomic,copy)NSString *icon;


-(instancetype)initWithDic:(NSDictionary*)dic;
 
+ (instancetype)MusicDataWithDic:(NSDictionary *)dict;


@end


