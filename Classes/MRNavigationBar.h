//
//  MRNavigationBar.h
//  MRNavigationBar
//
//  Created by MrXir on 2017/12/22.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRNavigationBar : UIView

@property (nonatomic, copy) NSString *title;

/** pop 或 web view goback */
@property (nonatomic, weak) IBOutlet UIButton *backButton;

/** web view pop */
@property (nonatomic, weak) IBOutlet UIButton *exitButton;


@property (nonatomic, weak) IBOutlet UIView *contentView;

@property (nonatomic, assign) IBOutlet UIViewController *controller;

@end
