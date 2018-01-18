//
//  SecondViewController.m
//  MRNavigationBar
//
//  Created by MR on 2017/12/24.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import "SecondViewController.h"

#import "MRNavigationBar.h"

@interface SecondViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"🛋";
    
    self.navigationBar.tintColor = [UIColor redColor];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载...");
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
