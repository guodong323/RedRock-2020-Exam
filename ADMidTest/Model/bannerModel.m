//
//  bannerModel.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "bannerModel.h"

@implementation bannerModel

-(instancetype)initWithDic:(NSDictionary*)dict {
    if (self = [super init]) {
        self.picUrl = dict[@"blurPicUrl"];
        self.songName = dict[@"name"];
        self.artist = dict[@"name"];
    }
    return self;
}
 
+ (instancetype)collectionViewWithDic:(NSDictionary *)dict {
    bannerModel *banner = [[bannerModel alloc] init];
    [banner setValuesForKeysWithDictionary:dict];
    return banner;
}


@end
