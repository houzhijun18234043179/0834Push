//
//  AllTableViewController.h
//  KKKKKKK
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol AllTableViewControllerDelegate <NSObject>
//
//- (void)pushDetailViewWith:(NSString *)string;
//
//@end

@interface AllTableViewController : UITableViewController

@property (nonatomic, strong) NSString * columnId;

@property (nonatomic, strong) NSString * feedId;


//@property (nonatomic, weak) id <AllTableViewControllerDelegate> delegate;

@end
