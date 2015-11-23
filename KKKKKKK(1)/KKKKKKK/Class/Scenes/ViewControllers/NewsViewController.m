//
//  NewsViewController.m
//  KKKKKKK
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewsViewController.h"
#import "ViewPagerController.h"
#import "AllTableViewController.h"
#import "DetailViewController.h"

#define kFrame(index) CGRectMake(viewWidth * index, 0, viewWidth, viewHeight - 144)

@interface NewsViewController () <ViewPagerDataSource, ViewPagerDelegate>

@property (nonatomic, strong) NSArray *titlesArray;

@property (nonatomic, strong) NSArray *columnIdArray;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    
    self.titlesArray = @[@"全部", @"氪TV", @"O2O", @"专栏", @"Fun", @"新硬件"];
    self.columnIdArray = @[@"all", @"18", @"25", @"16", @"19", @"20"];
    self.dataSource = self;
    self.delegate = self;
    self.title = @"新闻";
    [super viewDidLoad];
    
    
}





#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return [self.titlesArray count];
}


- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.text = [self.titlesArray objectAtIndex:index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}


- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    
    AllTableViewController * allVC = [AllTableViewController new];
    
//    allVC.delegate = self;
    
    allVC.columnId = self.columnIdArray[index];
    
    return allVC;
}





#pragma mark - ViewPagerDelegate

- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
            break;
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        default:
            break;
    }
    
    return value;
}



- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor blueColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
