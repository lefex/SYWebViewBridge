//
//  SYHybridWebView+LifeCycle.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/26.
//

#import "SYHybridWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYHybridWebView (LifeCycle)

- (void)syOnLoad;
- (void)syOnShow;
- (void)syOnHide;
- (void)syOnUnload;

@end

NS_ASSUME_NONNULL_END
