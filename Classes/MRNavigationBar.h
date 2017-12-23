//
//  MRNavigationBar.h
//  MRNavigationBar
//
//  Created by MrXir on 2017/12/22.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _BarView : UIView

@property (nonatomic, weak) IBOutlet UINavigationBar *systemBar;

/** pop 或 web view goback */
@property (nonatomic, weak) IBOutlet UIButton *backButton;

/** web view pop */
@property (nonatomic, weak) IBOutlet UIButton *exitButton;

@end

@interface MRNavigationBar : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, weak) IBOutlet _BarView *barView;

@property (nonatomic, assign) IBOutlet UIViewController *controller;

@end

@interface UIViewController (FindMRNavigationBar)

@property (nonatomic, strong, readonly) MRNavigationBar *navigationBar;

@end
