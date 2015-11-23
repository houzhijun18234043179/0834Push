//
//  Url.h
//  KKKKKKK
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#ifndef KKKKKKK_Url_h
#define KKKKKKK_Url_h

// 新闻页面网址
#define kUrl(columnId) [NSString stringWithFormat:@"https://rong.36kr.com/api/v3/news?pageSize=20&columnId=%@&pagingAction=up", columnId]

// 详情页面网址
#define kDetailUrl(feedId) [NSString stringWithFormat:@"https://rong.36kr.com/api/v3/news/%@", feedId]

// 下拉刷新
#define kNewsMore_url(lastId, columnId) [NSString stringWithFormat:@"https://rong.36kr.com/api/v3/news?pageSize=20&lastId=%@&columnId=%@&pagingAction=down",lastId,columnId]

#define kFinanceUrl @"https://rong.36kr.com/api/v3/filter/company?financeStatus=3&page=1&pageSize=10"


#endif
