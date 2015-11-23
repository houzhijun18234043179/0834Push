//
//  DetailViewController.m
//  KKKKKKK
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DetailViewController.h"
#import "Url.h"
#import "News.h"


@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UILabel *webTitleLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webTitleLabel.text = self.news.title;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor magentaColor];
    
    // 网络请求
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:kDetailUrl(self.news.feedId)]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //NSLog(@"%@", kDetailUrl(_feedId));
    
    // 获取data数据
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    //KVC要显示的内容
    NSString * titleString = dataDic[@"data"][@"title"];
    NSString * contentString = dataDic[@"data"][@"content"];
    
    //让网页适配自己的屏幕(但是会有空白地方,所以下面加了一段JS来控制显示大小,JS不会没有关系,去网上一查一大堆)
    //    self.webView.scalesPageToFit = YES;
    
    //[注意]加载HTML格式内容 用下面这个方法, 这个方法可以把HTML格式的内容转换
    //NSString * string = [NSString stringWithFormat:@"%@%@", titleString, contentString];
    
    NSString * str = [NSString stringWithFormat:@"<head><style>img{align=\"center\";width:%fpx !important;}</style></head>%@%@",[UIScreen mainScreen].bounds.size.width -19, titleString, contentString];
    
    [self.webView loadHTMLString:str baseURL:nil];
    
}




//网页加载完毕代理
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //定义JS字符串(JS代码看不懂没有关系,只要知道怎么用就行了,网上很多代码)
    NSString *script = [NSString stringWithFormat:
                        //                        @"var script = document.createElement('script');"
                        //                        "script.type = 'text/javascript';"
                        //                        "script.text = \"function ResizeImages() { "
                        //                        "var myimg;"
                        //                        "var maxwidth=%f;" //屏幕宽度
                        //                        "document.body.style.fontSize=35;"
                        //                        "for(i=0;i <document.images.length;i++){"
                        //                        "myimg = document.images[i];"
                        //                        "myimg.height = maxwidth / (myimg.width/myimg.height);"
                        //                        "myimg.width = maxwidth;"
                        //                        "}"
                        //                        "}\";"
                        //                        "document.getElementsByTagName('p')   [0].appendChild(script);",self.view.frame.size.width];
                        //                        @"var script = document.createElement('script');"
                        //                        "script.type = 'text/javascript';"
                        //                        "script.text = \"function ResizeImages() { "
                        //                        "var myimg,oldwidth;"
                        //                        "var maxwidth=400;" // UIWebView中显示的图片宽度
                        //                        "for(i=0;i <document.images.length;i++){"
                        //                        "myimg = document.images;"
                        //                        "if(myimg.width > maxwidth){"
                        //                        "oldwidth = myimg.width;"
                        //                        "myimg.width = maxwidth;"
                        //                        "myimg.height = myimg.height * (maxwidth/oldwidth);" // 导致我们计算错误的地方
                        //                        "}"
                        //                        "}"
                        //                        "}\";"
                        //                        "document.body.style.fontSize=35;" // 字体大小
                        //                        "document.getElementsByTagName('head')[0].appendChild(script);"];
                        @"var script = document.createElement('script');"
                        "script.type = 'text/javascript';"
                        "script.text = \"function ResizeImages() { "
                        "var myimg,oldwidth;"
                        "var maxwidth = 500.0;" // UIWebView中显示的图片宽度
                        "for(i=0;i <document.images.length;i++){"
                        "myimg = document.images[i];"
                        "if(myimg.width > maxwidth){"
                        "oldwidth = myimg.width;"
                        "myimg.width = maxwidth;"
                        "}"
                        "}"
                        "}\";"
                        "document.body.style.fontSize=35;" // 字体大小
                        "document.getElementsByTagName('head')[0].appendChild(script);"];
    

    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    //添加JS
    [webView stringByEvaluatingJavaScriptFromString:script];
    
    //添加调用JS执行的语句
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}








@end
