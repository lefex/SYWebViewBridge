# Using SYWebViewBridge(iOS)

## Use

There provide two ways to use `SYWebViewBridge`.You can use `SYHybridWebViewController` or `SYHybridWebView` in your project. The best way is using `SYHybridWebViewController`. You can create a viewController inherit from `SYHybridWebViewController`.

1、Use`SYHybridWebViewController`(Recommend)

You can use SYHybridWebViewController or create a subclass of it. The http address is `http://localhost:9000/home.html`. We provide a web page in root directory `web`, you can download `SYWebViewBridge` and enter web path. Only excute `npm install`, then excute `npm run start:home`. The web page will auto open in you default broswer.

```objc
SYHybridWebViewController *viewController = [[SYHybridWebViewController alloc] init];
[viewController loadUrl:@"http://localhost:9000/home.html"];
[self.navigationController pushViewController:viewController animated:YES];
```

2、Use `SYHybridWebView`

The `SYHybridWebViewController` use `SYHybridWebView` as his webview. You can use `SYHybridWebView`. If you use lifecycle action, you should call lifecycle action in `SYHybridWebView+LifeCycle`, or you will not get lifecycle action.

```objc
WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
SYHybridWebView *webview = [[SYHybridWebView alloc] initWithFrame:self.view.bounds configuration:conf];
[self.view addSubview:webview];
```

## Custom plugin

There are so many apps in our world, every app have their own tasks. For this, we provide custom plugin system, so you can design you own bridge api qucikly. A plugin is an set of apis. We provide a example:

Sometimes, the web page send http request through app. So we must provide a custom a plugin to deal with network request. This is only a demo for you. 

The plugin must inherit from `SYBridgeBasePlugin`.

`SYBridgeBasePlugin.h`

```objc
@interface SYNetworkPlugin : SYBridgeBasePlugin

@end
```

`SYBridgeBasePlugin.m`

We create a `request:callback:` method in `SYNetworkPlugin` class, the method will called auto when receive the webview request action. follows:

```js
sendRequest() {
    sy.network.request({
        url: 'https://www.igetget.com/api/wap/footer',
        method: 'get',
        data: {
            from: 'SYWebViewBridge'
        },
        header: {
            'content-type': 'application/json'
        },
        success(res) {
            sy.debug.alert(res.data);
        },
        fail(err) {
            sy.debug.alert('network error');
        },
        complete(res) {
            console.log('request complete');
        }
    });
}
```

We get the url and other params, send a request through `NSURLSession`. We should call tha callback
block if we get a http response.

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

## Debug

You `toast` and `log` to debug your web page.