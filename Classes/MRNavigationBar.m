//
//  MRNavigationBar.m
//  MRNavigationBar
//
//  Created by MrXir on 2017/12/22.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import "MRNavigationBar.h"

@implementation _BarView

@end

@interface MRNavigationBar ()<UIGestureRecognizerDelegate, UIWebViewDelegate>

@property (nonatomic, assign) id<UIWebViewDelegate> originalWebViewDelegate;

@property (nonatomic, weak) __kindof UIWebView *webView;

@end

@implementation MRNavigationBar

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    [self reviseNavigationBarItems];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.controller.navigationController.interactivePopGestureRecognizer.delegate = (id)self.controller;
    
    self.barView.systemBar.translucent = NO;
    self.barView.systemBar.barTintColor = self.backgroundColor;
    
    UIImage *backImage = [[UIImage imageWithContentsOfFile:[self pathForResource:@"back" type:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.barView.backButton setImage:backImage forState:UIControlStateNormal];
    [self.barView.backButton setImage:backImage forState:UIControlStateHighlighted];
    
    [self.barView.backButton addTarget:self action:@selector(didClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.barView.exitButton addTarget:self action:@selector(didClickExitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.barView.backButton addTarget:self action:@selector(touchDownInside:) forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDown];
    [self.barView.backButton addTarget:self action:@selector(touchDownOutSide:) forControlEvents:UIControlEventTouchDragOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel];
    
    [self.barView.exitButton addTarget:self action:@selector(touchDownInside:) forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDown];
    [self.barView.exitButton addTarget:self action:@selector(touchDownOutSide:) forControlEvents:UIControlEventTouchDragOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel];

    [self.controller.view bringSubviewToFront:self];
}


- (void)touchDownInside:(UIButton *)button
{
    button.alpha = 0.5;
}

- (void)touchDownOutSide:(UIButton *)button
{
    button.alpha = 1;
}

- (void)reviseNavigationBarItems
{
    // find web view
    if (!self.webView) {
        
        for (id view in self.controller.view.subviews) {
            if ([view isKindOfClass:[UIWebView class]]) {
                self.webView = view;
                break;
            }
        }
        
    }
    
    if (self.webView == nil) {
        self.barView.exitButton.hidden = YES;
    } else {
        
        if (!self.originalWebViewDelegate) {
            if (self.webView.delegate != nil)
                self.originalWebViewDelegate = self.webView.delegate;
            self.webView.delegate = self;
        }
        
        if (![self.webView canGoBack]) {
            self.barView.exitButton.hidden = YES;
        } else {
            self.barView.exitButton.hidden = NO;
        }
        
    }
    
    // find nvaigation child view controller
    if (self.controller.navigationController.viewControllers.count > 1) {
        self.barView.backButton.hidden = NO;
    } else {
        self.barView.backButton.hidden = YES;
    }
}

- (void)didClickBackButton:(UIButton *)button
{
    if (self.webView == nil) {
        [self.controller.navigationController popViewControllerAnimated:YES];
    } else {

        if ([self.webView canGoBack]) {
            [self.webView goBack];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (![self.webView canGoBack]) {
                    self.barView.exitButton.hidden = YES;
                }
            });

        } else {
            [self.controller.navigationController popViewControllerAnimated:YES];
        }

    }
}

- (void)didClickExitButton:(UIButton *)button
{
    [self.controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark - web view delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%s", __FUNCTION__);
    
    if ([self.originalWebViewDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [self.originalWebViewDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    [self reviseNavigationBarItems];
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s", __FUNCTION__);
    
    if ([self.originalWebViewDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.originalWebViewDelegate webViewDidStartLoad:webView];
    }
    
    [self reviseNavigationBarItems];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s", __FUNCTION__);
    
    if ([self.originalWebViewDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.originalWebViewDelegate webViewDidFinishLoad:webView];
    }
    
    [self reviseNavigationBarItems];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
    
    if ([self.originalWebViewDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.originalWebViewDelegate webView:webView didFailLoadWithError:error];
    }
    
    [self reviseNavigationBarItems];
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

@implementation UIViewController (FindMRNavigationBar)

@dynamic navigationBar;

- (MRNavigationBar *)navigationBar
{
    for (MRNavigationBar *navigarionBar in self.view.subviews) {
        if ([navigarionBar isKindOfClass:[MRNavigationBar class]]) {
            return navigarionBar;
        }
    }
    return nil;
}

@end
