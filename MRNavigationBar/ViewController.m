//
//  ViewController.m
//  MRNavigationBar
//
//  Created by MrXir on 2017/12/22.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import "ViewController.h"

#import "MRNavigationBar.h"

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationBar.title = @"首页";
    self.navigationBar.titleColor = [UIColor blackColor];
    self.navigationBar.tintColor = [UIColor blueColor];

    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
