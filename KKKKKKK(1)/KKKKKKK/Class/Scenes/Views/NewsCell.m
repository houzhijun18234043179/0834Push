//
//  NewsCell.m
//  KKKKKKK
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"
#import "UIImageView+WebCache.h"

@interface NewsCell ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UIImageView *featureImg;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;

@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation NewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)fetchNews:(News *)news
{
    self.userName.text = news.name;
    self.time.text = [self changeTimeToStringWithPublishTime:news.publishTime];
    self.title.text = news.title;
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:news.avatar]];
    [self.featureImg sd_setImageWithURL:[NSURL URLWithString:news.featureImg]];
    [self.userAvatar layoutIfNeeded];
    self.userAvatar.layer.cornerRadius = CGRectGetWidth(self.userAvatar.frame)/2;
    self.userAvatar.layer.masksToBounds = YES;
    
    self.commentCount.text = [NSString stringWithFormat:@"%ld", news.commentCount];
    self.type.text = news.columnName;

}


- (NSString *)changeTimeToStringWithPublishTime:(NSInteger)publishTime {
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval sinceNow =[date timeIntervalSince1970] - publishTime / 1000;
    NSString * timeString = @"";
    if (sinceNow/3600<1) {
        
        timeString = [NSString stringWithFormat:@"%f", sinceNow/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        int num= [timeString intValue];
        
        if (num <= 1) {
            
            timeString = [NSString stringWithFormat:@"刚刚..."];
            return timeString;
        }else{
            
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
            return timeString;
        }
    }
    if (sinceNow/3600>1&&sinceNow/86400<1) {
        
        timeString = [NSString stringWithFormat:@"%f", sinceNow/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
        return timeString;
    }
    
    if (sinceNow/86400>1) {
        
        timeString = [NSString stringWithFormat:@"%f", sinceNow/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        int num=[timeString intValue];
        
        if (num<2) {
            
            timeString=[NSString stringWithFormat:@"昨天"];
            return timeString;
        }else if (num==2){
            
            timeString = [NSString stringWithFormat:@"前天"];
            return timeString;
        }else if (num>2&&num<7){
            
            timeString = [NSString stringWithFormat:@"%@天前", timeString];
            return timeString;
        }else if (num >= 7 && num <=30) {
            
            timeString = [NSString stringWithFormat:@"1周前"];
            return timeString;
        }else if(num > 30 && num <=365){
            
            int month=sinceNow/(86400*30);
            timeString=[NSString stringWithFormat:@"%d",month];
            timeString = [NSString stringWithFormat:@"%@周前",timeString];
            return timeString;
        }else if (num >365){
            
            int year=sinceNow/(86400*365);
            timeString=[NSString stringWithFormat:@"%d",year];
            timeString = [NSString stringWithFormat:@"%@年前",timeString];
            return timeString;
        }
    }
    return timeString;
}


























- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
