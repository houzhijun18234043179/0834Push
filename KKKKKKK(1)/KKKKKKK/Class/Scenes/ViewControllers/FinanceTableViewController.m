//
//  FinanceTableViewController.m
//  KKKKKKK
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FinanceTableViewController.h"
#import "FinanceCell.h"
#import "Url.h"
#import "Finance.h"

@interface FinanceTableViewController ()

@property (nonatomic, strong) NSMutableArray * financeArray;

@end

@implementation FinanceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registFinanceCell];
    [self parseData];

}


- (void) registFinanceCell
{
    UINib * nib = [UINib nibWithNibName:@"FinanceCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"FinanceCell"];
    
}


// 网络请求, 数据解析
- (void)parseData
{
    
    NSURL * url = [NSURL URLWithString:kFinanceUrl];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    __weak FinanceTableViewController * weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"%@---", data);
        if (data) {
        
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * array = dic[@"data"][@"data"];

            for (NSDictionary * dict in array) {
                
                Finance * financeModel = [[Finance alloc]init];
                
                [financeModel setValuesForKeysWithDictionary:dict];
                
                NSDictionary * user = dict[@"user"];
                
                [financeModel setValuesForKeysWithDictionary:user];

                [weakSelf.financeArray addObject:financeModel];
            }
        }

        [weakSelf.tableView reloadData];
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return _financeArray.count;

}


// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    FinanceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FinanceCell" forIndexPath:indexPath];
    
    Finance * finance = self.financeArray[indexPath.row];
    
    [cell fetchFinace:finance];
//    cell.nameLabel.text = @"付大海";
    
    
    return cell;
}



// 自定义cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;

}



// 懒加载
- (NSMutableArray *)financeArray {
    if (!_financeArray) {
        
        _financeArray = [NSMutableArray array];
    }
    return _financeArray;
}






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
