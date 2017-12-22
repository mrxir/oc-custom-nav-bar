//
//  MRNavigationBar.m
//  MRNavigationBar
//
//  Created by MrXir on 2017/12/22.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import "MRNavigationBar.h"

@interface MRNavigationBar ()<UIGestureRecognizerDelegate>

@end

@implementation MRNavigationBar

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.backButton setImage:[UIImage imageWithContentsOfFile:[self pathForResource:@"back" type:@"png"]] forState:UIControlStateNormal];
    
    self.controller.navigationController.interactivePopGestureRecognizer.delegate = (id)self.controller;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - unit

- (NSString *)pathForResource:(NSString *)resource type:(NSString *)type
{
    NSBundle *imageBundle = nil;
    NSBundle *bundle = [NSBundle bundleForClass:[MRNavigationBar class]];
    NSURL *url = [bundle URLForResource:@"MRNavigationBar" withExtension:@"bundle"];
    imageBundle = [NSBundle bundleWithURL:url];
    return [imageBundle pathForResource:resource ofType:type];
}

@end
