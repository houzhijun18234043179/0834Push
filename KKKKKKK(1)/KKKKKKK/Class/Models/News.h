//
//  News.h
//  KKKKKKK
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, strong) NSString * title;  // 标题
@property (nonatomic, strong) NSString * columnName;   // 类型
@property (nonatomic, assign) NSInteger commentCount; // 品论数量
@property (nonatomic, strong) NSString * name;         // user名
@property (nonatomic, strong) NSString * featureImg;   // 图片
@property (nonatomic, strong) NSString * avatar;       // user头像
@property (nonatomic, strong) NSString * feedId;    // 提要
@property (nonatomic, assign) NSInteger publishTime;  // 发表时间


@end
