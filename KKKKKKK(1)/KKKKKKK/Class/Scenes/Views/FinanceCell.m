//
//  FinamceCell.m
//  KKKKKKK
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FinanceCell.h"
#import "Finance.h"
#import "UIImageView+WebCache.h"

@implementation FinanceCell

- (void)awakeFromNib {
    // Initialization code
}



- (void)fetchFinace:(Finance *)finance
{
    self.nameLabel.text = finance.name;
    self.tagsLabel.text = finance.industry;
    self.financeTargetLabel.text = finance.financeTarget;
    self.briefLabel.text = finance.brief;
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:finance.logo]];
    
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
