//
//  MusicModel.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "MusicModel.h"
#import <AFNetworking.h>
@implementation MusicModel

- (instancetype)initWithDic:(NSDictionary *)dict{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"coverImgUrl"];
        self.count = dict[@"playCount"];
    }
    return self;
}

+ (instancetype)MusicDataWithDic:(NSDictionary *)dict{
    MusicModel *Data = [[MusicModel alloc] init];
    [Data setValuesForKeysWithDictionary:dict];
    return Data;
}



@end
