//
//  bannerModel.h
//  ADMidTest
//
//  Created by 阿栋 on 2020/5/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface bannerModel : NSObject

@property(nonatomic,strong) NSString *picUrl;

@property(nonatomic,strong) NSString *songName;

@property(nonatomic,strong) NSString *artist;

-(instancetype)initWithDic:(NSDictionary*)dict;
 
+ (instancetype)collectionViewWithDic:(NSDictionary *)dict;

@end


