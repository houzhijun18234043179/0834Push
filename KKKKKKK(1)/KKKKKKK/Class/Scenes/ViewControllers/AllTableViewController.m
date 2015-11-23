//
//  AllTableViewController.m
//  KKKKKKK
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AllTableViewController.h"
#import "NewsCell.h"
#import "News.h"
#import "Url.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "TVCell.h"
#import "RESideMenu.h"
#import "UIImageView+WebCache.h"
#import "DJPageView.h"

@interface AllTableViewController ()

@property (nonatomic, strong) NSMutableArray * newsArray;

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, strong) NSMutableArray * imageArray;

@end

@implementation AllTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registCell];
    [self registTVCell];
    [self parseDataFromUrl:kUrl(self.columnId)];
    
    //    [self headerRereshing];
    //    [self footerRereshing];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    //  [self setTableViewHeader];
    
}


// 下拉刷新
- (void)headerRereshing
{
    
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
    
}



// 上拉加载
- (void)footerRereshing
{
    News * new = self.newsArray.lastObject;
    
    NSString * feedId = new.feedId;
    
    [self parseDataFromUrl:kNewsMore_url(feedId, self.columnId)];
    
    [self.tableView.footer endRefreshing];
    
}





// 注册cell
- (void)registCell
{
    
    UINib * nib = [UINib nibWithNibName:@"NewsCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"NewsCell"];
    
}


// 注册TVcell
- (void)registTVCell
{
    UINib * nib = [UINib nibWithNibName:@"TVCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TVCell"];
    
    
}



// 网络请求, 数据解析
- (void)parseDataFromUrl:(NSString *)urlString
{
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    self.imageArray = [NSMutableArray new];
    
    __weak AllTableViewController * weakSelf = self;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * array = dic[@"data"][@"data"];
            
            for (NSDictionary * dict in array) {
                
                News * newsModel = [News new];
                
                [newsModel setValuesForKeysWithDictionary:dict];
                
                NSDictionary * user = dict[@"user"];
                
                [newsModel setValuesForKeysWithDictionary:user];
                
                [weakSelf.newsArray addObject:newsModel];
                
                [self.imageArray addObject:newsModel.featureImg];
                
            }
            
        }
        //NSLog(@"%@", self.newsArray);
        
        [weakSelf.tableView reloadData];
        
        if ([self.columnId isEqualToString:@"all"]) {
            
            self.imageArray = [NSMutableArray arrayWithObjects:self.imageArray[0],self.imageArray[1],self.imageArray[2],self.imageArray[3],self.imageArray[4], nil];
            
            self.tableView.tableHeaderView = [weakSelf setTableViewHeader];
            
        }
    
    }];
    
    
}





// 懒加载 !!!!! 使用下划线_
- (NSMutableArray *)newsArray
{
    if (!_newsArray) {
        
        _newsArray = [NSMutableArray new];
        
    }
    
    return _newsArray;
}



//- (void)pushDetailViewWith:(NSString *)string {
//
//    DetailViewController * detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
//
//    [self.navigationController pushViewController:detailVC animated:YES];
//
//    NSLog(@"wqe");
//}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return _newsArray.count;
}


// tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if ([self.columnId isEqualToString:@"18"]) {
        
        TVCell * tvCell = [tableView dequeueReusableCellWithIdentifier:@"TVCell" forIndexPath:indexPath];
        
        News * new = self.newsArray[indexPath.row];
        
        [tvCell fetchNews:new];
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        return tvCell;
        
    } else {
        
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        
        News * news = self.newsArray[indexPath.row];
        
        [cell fetchNews:news];
        
        return cell;
    }
    
}



// 自定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.columnId isEqualToString:@"18"]) {
        
        return 170;
        
    }else {
        
        return 150;
        
    }
}


// Cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if ([self.delegate respondsToSelector:@selector(pushDetailViewWith:)]) {
    //
    //        News * news = self.newsArray[indexPath.row];
    //
    //        NSString * string = news.feedId;
    //
    //        [self.delegate pushDetailViewWith:string];
    //    }
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //
    DetailViewController * detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController_id"];
    
    News * news = self.newsArray[indexPath.row];
    
    detailVC.news = news;
    
    
    
    [self showViewController:detailVC sender:nil];
    //
    //    DetailViewController * detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    //    [self.navigationController pushViewController:detailVC animated:YES];
}



// 轮播图
- (UIView *) setTableViewHeader
{
/**
//    if ([self.columnId isEqualToString:@"all"]) {
//        
//        UIView * myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
//        
//        self.scrollView = [[UIScrollView alloc] initWithFrame:myView.frame];
//        [myView addSubview:self.scrollView];
//        
//        CGFloat width = self.scrollView.frame.size.width;
//        CGFloat hight = self.scrollView.frame.size.height;
//        
//        for (int i = 1; i < 11; i++) {
//            
//            UIImageView * imageView = [UIImageView new];
//            
//            CGFloat imageX = (i -1) * width;
//            CGFloat imageY = 0;
//            
//            imageView.frame = CGRectMake(imageX, imageY, width, hight);
//            
//            News * new = self.newsArray[i];
//            
//            [imageView sd_setImageWithURL:[NSURL URLWithString:new.featureImg]];
//            
//            [self.scrollView addSubview:imageView];
//        }
//
//        self.scrollView.contentSize = CGSizeMake(10 * width, 0);
//        
//        self.scrollView.pagingEnabled = YES;
//        
//        self.scrollView.delegate = self;
//        
//        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(200, 170, 150, 30)];
//
//        self.pageControl.numberOfPages = 9;
//        
//        // 设置未选中圆点的颜色
//        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
//        
//        [myView addSubview:self.pageControl];
//        
//        [self addScrollTimer];
//        
//        self.tableView.tableHeaderView = myView;
//        
//        
//    }
*/
 
      UIView * myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
  
    if ([self.columnId isEqualToString:@"all"]) {
        
        DJPageView *pageView = [[DJPageView alloc] initPageViewFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200) webImageStr:self.imageArray didSelectPageViewAction:^(NSInteger index) {
            ;NSLog(@"%ld",index);
        }];

        
        //停留时间
        pageView.duration = 2.0;
   
        pageView.pageBackgroundColor = [UIColor clearColor];
      
        pageView.pageIndicatorTintColor = [UIColor whiteColor];
     
        pageView.currentPageColor = [UIColor grayColor];
      
        [myView addSubview:pageView];
    
    }
    
    return myView;
    
}

/**
- (void) addScrollTimer
{
    self.timer = [NSTimer timerWithTimeInterval:2.f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}


- (void) removeScrollTimer
{
    
    [self.timer invalidate];
    
    self.timer = nil;
    
}


- (void) nextPage
{
    CGFloat width = self.scrollView.frame.size.width;
    
    NSInteger currentPage = self.scrollView.contentOffset.x / width;
   
    currentPage ++;
   
    if (currentPage == 10) {
    
        currentPage = 0;
    }
   
    self.pageControl.currentPage = currentPage;
    
    CGPoint offset = CGPointMake(currentPage * width, 0.f);
   
    [UIView animateWithDuration:.2f animations:^{
      
        self.scrollView.contentOffset = offset;

    }];
    
}
*/









/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
