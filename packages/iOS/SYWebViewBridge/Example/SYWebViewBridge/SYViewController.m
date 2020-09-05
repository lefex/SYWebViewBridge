//
//  SYViewController.m
//  SYWebViewBridge
//
//  Created by wsy on 09/05/2020.
//  Copyright (c) 2020 wsy. All rights reserved.
//

#import "SYViewController.h"
#import <SYHybridWebView.h>

@interface SYViewController ()

@property (nonatomic, strong) SYHybridWebView *webview;

@end

@implementation SYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SYWebViewBridge";
    
    WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
    _webview = [[SYHybridWebView alloc] initWithFrame:self.view.bounds configuration:conf];
    [self.view addSubview:_webview];
    
    _webview.sourceUrl = @"http://localhost:9000/home.html";
}


@end
