//
//  MRNavigationBar.m
//  MRNavigationBar
//
//  Created by MrXir on 2017/12/22.
//  Copyright © 2017年 MRXIR Inc. All rights reserved.
//

#import "MRNavigationBar.h"

@interface MRNavigationBar ()<UIGestureRecognizerDelegate, UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftButton1Width;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *leftButton2Width;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *rightButton1Width;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *rightButton2Width;

@property (nonatomic, assign) id<UIWebViewDelegate> originalWebViewDelegate;

@property (nonatomic, strong, readonly) __kindof UIWebView *webView;

@end

@implementation MRNavigationBar

#pragma mark - setter and getter

@synthesize webView = _webView;

- (UIWebView *)webView
{
    if (_webView != nil) {
        return _webView;
    } else {
        for (id view in self.controller.view.subviews) {
            if ([view isKindOfClass:[UIWebView class]]) {
                return _webView = view;
            }
        }
        return _webView;
    }
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    [self.controller.view bringSubviewToFront:self];
    
    [self setupNavigationBarItemAppearance];
    
    [self setupNavigationBarItemActions];
    
    [self delegateWebViewIfNeed];
    
}

- (void)setupNavigationBarItemAppearance
{
    // isn't root
    if (self.controller.navigationController.viewControllers.count > 1) {
        
        [self _showLeftButtonWithType:@"Pop"];
        
        if (self.webView != nil) {
            
            if ([self.webView canGoBack]) {
                [self _showLeftButtonWithType:@"GoBack"];
            } else {
                [self _hideLeftButton2WhenCanNotGoBack];
            }
            
        }
        
    } else {
        
        // is root
        [self _hideLeftButtonsWhenCanNotPop];
    }
}

- (void)setupNavigationBarItemActions
{
    [self.leftButton1 addTarget:self action:@selector(buttonActionHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton2 addTarget:self action:@selector(buttonActionHandler:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)delegateWebViewIfNeed
{
    if (!self.webView.delegate) {
        self.webView.delegate = self;
    } else {
        if (self.webView.delegate != self) {
            self.originalWebViewDelegate = self.webView.delegate;
            self.webView.delegate = self;
        }
    }
}

- (void)buttonActionHandler:(UIButton *)button
{
    if (self.webView != nil) {
        if ([self.webView canGoBack]) {
            if (button == self.leftButton1) [self.webView goBack];
            if (button == self.leftButton2) [self.controller.navigationController popViewControllerAnimated:YES];
        } else {
            [self.controller.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self.controller.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - web view delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //NSLog(@"%s", __FUNCTION__);
    
    if ([self.originalWebViewDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [self.originalWebViewDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    [self setupNavigationBarItemAppearance];
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //NSLog(@"%s", __FUNCTION__);
    
    if ([self.originalWebViewDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.originalWebViewDelegate webViewDidStartLoad:webView];
    }
    
    [self setupNavigationBarItemAppearance];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //NSLog(@"%s", __FUNCTION__);
    
    if ([self.originalWebViewDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.originalWebViewDelegate webViewDidFinishLoad:webView];
    }
    
    [self setupNavigationBarItemAppearance];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //NSLog(@"%s", __FUNCTION__);
    
    if ([self.originalWebViewDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.originalWebViewDelegate webView:webView didFailLoadWithError:error];
    }
    
    [self setupNavigationBarItemAppearance];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - # PRIVATE METHOD #

#pragma mark - show

- (void)_showLeftButtonWithType:(NSString *)popOrGoBack
{
    if ([popOrGoBack isEqualToString:@"Pop"]) {
        
        [self.leftButton1 setImage:[UIImage imageWithContentsOfFile:[self pathForResource:@"back" type:@"png"]] forState:UIControlStateNormal];
        self.leftButton1Width.constant = 50;
        
        
    } else if ([popOrGoBack isEqualToString:@"GoBack"]) {
        
        [self.leftButton1 setImage:[UIImage imageWithContentsOfFile:[self pathForResource:@"back" type:@"png"]] forState:UIControlStateNormal];
        self.leftButton1Width.constant = 50;
        
        [self.leftButton2 setImage:[UIImage imageWithContentsOfFile:[self pathForResource:@"close" type:@"png"]] forState:UIControlStateNormal];
        self.leftButton2Width.constant = 50;
        
    }
    
}

#pragma mark - hide

- (void)_hideLeftButton2WhenCanNotGoBack
{
    NSLog(@"%s", __FUNCTION__);
    self.leftButton2Width.constant = 0;
}

- (void)_hideLeftButtonsWhenCanNotPop
{
    NSLog(@"%s", __FUNCTION__);
    self.leftButton1Width.constant = 0;
    self.leftButton2Width.constant = 0;
}

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
