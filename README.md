
An iOS *modern bridge* for sending messages between Objective-C and JavaScript in WKWebView. Include FE and iOS.

The project is in the beta phase and is being used in my own projects.

![logo](https://s1.ax1x.com/2020/10/10/06u4dP.md.png)

## Documentation

[Docs Detail](https://lefex.github.io/SYWebViewBridge/)


### Use in FE

You need to download the project [SYJSBridge](https://github.com/lefex/SYJSBridge) to use in web page。

`sy-webview-bridge` provide a system plugin that can show a modal alert in App. This code to show a modal alert and will receive a success callback when user click OK or Cancel button.

```js
sy.system.showModal({
    title: 'SYWebViewBridge',
    content: 'An iOS modern bridge for sending messages between Objective-C and JavaScript in WKWebView.',
    showCancel: true,
    cancelText: 'Cancel',
    confirmText: 'OK',
    // success
    success: function(res) {
        if (res.confirm) {
            // user click OK button
        }
        else {
            // user click Cancel button
        }
    },
    // fail
    fail: function(err) {
        console.log(err);
    },
    // call when success or fail
    complete: function(res) {
        console.log(res);
    }
});
```

[more docs](https://lefex.github.io/SYWebViewBridge/)

### Use in iOS
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

### Custom plugin

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

[more docs](https://lefex.github.io/SYWebViewBridge/)

## Questions

If you have any questions, you can pay attention to my wechat official account 素燕. 

## Contribution

Please make sure to read the [Contributing Guide](https://github.com/lefex/SYWebViewBridge/blob/master/.github/contributing.md) before making a pull request.

## License

[MIT](http://opensource.org/licenses/MIT)

Copyright (c) 2020-present, Suyan Wang
