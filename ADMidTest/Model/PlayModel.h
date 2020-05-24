//
//  PlayModel.h
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

/**
 播放音乐模型
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayModel : NSObject
//音乐名
@property (strong, nonatomic) NSString *musicName;
//演唱者
@property (strong, nonatomic) NSString *artist;
//音乐图片
@property (strong, nonatomic) NSString *musicIcon;
//音乐链接
@property (strong, nonatomic) NSString *musicUrl;
//音乐时常
@property (strong, nonatomic) NSNumber *duration;

-(instancetype)initWithDic:(NSDictionary*)dict;
 


@end

NS_ASSUME_NONNULL_END
