//
//  TVCell.m
//  KKKKKKK
//
//  Created by lanou3g on 15/10/7.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TVCell.h"
#import "News.h"
#import "UIImageView+WebCache.h"

@interface TVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation TVCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)fetchNews:(News *)news
{
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:news.featureImg]];
    
    self.titleLabel.text = news.title;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
