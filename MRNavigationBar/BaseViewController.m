//
//  BaseViewController.m
//  MRNavigationBar
//
//  Created by MR on 2017/12/24.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import "BaseViewController.h"

#import <UINavigationController+FDFullscreenPopGesture.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fd_prefersNavigationBarHidden = YES;
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
