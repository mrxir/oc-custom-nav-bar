//
//  MRNavigationBar.h
//  MRNavigationBar
//
//  Created by MrXir on 2017/12/22.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRNavigationBar : UIView

#pragma mark - center

@property (nonatomic, weak) IBOutlet UILabel *centerLabel;

#pragma mark - left

@property (nonatomic, weak) IBOutlet UIButton *leftButton1;

@property (nonatomic, weak) IBOutlet UIButton *leftButton2;

#pragma mark - right

@property (nonatomic, weak) IBOutlet UIButton *rightButton1;

@property (nonatomic, weak) IBOutlet UIButton *rightButton2;

#pragma mark - setup

@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, assign) IBOutlet UIViewController *controller;

@end

@interface UIViewController (FindMRNavigationBar)

@property (nonatomic, strong, readonly) MRNavigationBar *navigationBar;

@end
