
An iOS *modern bridge* for sending messages between Objective-C and JavaScript in WKWebView. Include FE and iOS.

**I am writing the library.....**
**not release**

[![tested with jest](https://img.shields.io/badge/tested_with-jest-99424f.svg)](https://github.com/facebook/jest)
[![jest](https://jestjs.io/img/jest-badge.svg)](https://github.com/facebook/jest)

## Project

```js
├── LICENSE
├── README.md
├── deploy.sh
├── docs // docs site
│   ├── README.md
│   ├── config
│   ├── guide
│   └── index.md
├── package-lock.json
├── package.json
├── packages
│   ├── SYWebViewBridge // iOS project
│   └── sy-webview-bridge // fe project
└── web // the fe pages demo
    ├── home
    ├── index.tpl.html
    ├── package-lock.json
    ├── package.json
    └── webpack.config.js
```

## Documentation

### Use in FE

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


## Questions

If you have any questions, you can pay attention to my wechat official account 素燕. 

![](https://upload-images.jianshu.io/upload_images/1664496-1471f633bfc7d877.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Issues

## Contribution

Please make sure to read the [Contributing Guide](https://github.com/lefex/SYWebViewBridge/blob/master/.github/contributing.md) before making a pull request.

## License

[MIT](http://opensource.org/licenses/MIT)

Copyright (c) 2020-present, Suyan Wang
