//
//  SYHybridWebViewController.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/26.
//

#import <UIKit/UIKit.h>

@class SYHybridWebView;

NS_ASSUME_NONNULL_BEGIN

@interface SYHybridWebViewController : UIViewController

@property (nonatomic, strong, readonly) SYHybridWebView *webview;

- (void)loadUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
