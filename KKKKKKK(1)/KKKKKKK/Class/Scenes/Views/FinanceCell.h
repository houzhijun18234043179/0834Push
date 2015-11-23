//
//  FinamceCell.h
//  KKKKKKK
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Finance.h"

@interface FinanceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;

@property (weak, nonatomic) IBOutlet UILabel *financeTargetLabel;

@property (weak, nonatomic) IBOutlet UILabel *briefLabel;


- (void)fetchFinace:(Finance *)finance;


@end
