# Using SYWebViewBridge(iOS)

You can use `SYHybridWebViewController` or `SYHybridWebView`.

1、use`SYHybridWebViewController` 

```objective-c
SYHybridWebViewController *viewController = [[SYHybridWebViewController alloc] init];
[viewController loadUrl:@"http://localhost:9000/home.html"];
[self.navigationController pushViewController:viewController animated:YES];
```

2、use `SYHybridWebView`

```objc
WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
SYHybridWebView *webview = [[SYHybridWebView alloc] initWithFrame:self.view.bounds configuration:conf];
[self.view addSubview:webview];
```

## custom plugin

Custom a plugin to deal with network request. The plugin must extend from `SYBridgeBasePlugin`.

`SYBridgeBasePlugin.h`

```objc
@interface SYNetworkPlugin : SYBridgeBasePlugin

@end
```

`SYBridgeBasePlugin.m`

```objc
@implementation SYNetworkPlugin

- (void)request:(SYBridgeMessage *)msg callback:(SYPluginMessageCallBack)callback {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSString *url = msg.paramDict[@"url"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error && data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                callback(@{
                    kSYCallbackType: kSYCallbackSuccess,
                    @"data": dict ?: @{}
                }, msg);
            }
            else {
                callback(@{
                    kSYCallbackType: kSYCallbackFail
                }, msg);
            }
        });
    }];
    [task resume];
}

@end
```