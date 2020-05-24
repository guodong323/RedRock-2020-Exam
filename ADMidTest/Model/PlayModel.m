//
//  PlayModel.m
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "PlayModel.h"

@implementation PlayModel
-(instancetype)initWithDic:(NSDictionary*)dict {
    if (self = [super init]) {
        self.musicName = dict[@"name"];
        self.artist = dict[@"name"];
        self.musicIcon = dict[@"picUrl"];
        self.duration = dict[@"dt"];
        self.musicUrl = dict[@"url"];
    }
    return self;
}
 


@end
