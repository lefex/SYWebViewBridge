在 App 开发当中，Hybrid 框架发展越来越成熟， webview 和 App 进行通信只是最基本的功能，现如今对 Hybrid 框架要求越来越高。比如小程序框架，其实也可以把它看做是一个 Hybrid 框架。我认为一个好的 Hybrid 框架需要支持下面这些特性：

1、：： 与 iOS、Android App 可进行无差别通信；

2、通信接口需要保证简单，webview 和 app 可进行任意消息发送与接收；

3、调试简单，前端页面可在宿主环境中便捷调试，不依赖 app；

4、可灵活扩展 js-native 交互 bridge；

5、支持 webview 的声明周期、系统等信息 bridge；

如果你开发过小程序，一定是用过下面这个 api，它的作用就是吊起 App 中的一个弹窗，当用户点击「确定」或者「取消」按钮后，webview 会接收到回调函数：

```js
wx/swan.showModal({
    title: '弹窗提示',
    content: '你对我满意吗？',
    showCancel: true,
    cancelText: 'Cancel',
    confirmText: 'OK',
    // 成功回调函数
    success: function(res) {
        // 点击 ok 按钮
        if (res.confirm) {
            console.log('click OK button');
        }
        else {
            console.log('click Cancel button');
        }
    },
    // 失败回调函数
    fail: function(err) {
        // js native 交互时发生异常
        console.log(err);
    },
    // 成功或者失败的回调函数
    complete: function(res) {
        // 无论 success 还是 fail 都会调用
        console.log(res);
    }
});
```

`showModal`是 js-native 交互的 api，也是 Hybrid 框架提供的端能力。如果有这样的 Hybrid 框架，用起来是不是很爽？

今天介绍的 SYWebViewBridge 完全做到了类似 `showModal` 这种通信写法。它是一个更现代 Hybrid 框架，可在前端和 iOS 中使用，目前不支持 Android，不过实现 Android 端也非常简单，只需遵循它的通信标准即可。



### 前端使用

在前端开发中，直接使用类 SYBridge 创建一个实例，并挂载到 window 上，保证一个页面中只有一个 bridge 实例，在其它子组件可以直接使用该实例。在组件使用之前，业务方保证已经把 SYBridge 挂载到了 window 上。SYBridge 默认实例名是 sy，可自行修改，这个实例名是 webview 与 app 之间通信的基石。

```js
// 设置 SYBridge 在 window 上挂载的实例名
const namespace = 'sy';
// 创建 SYBridge 实例并挂载到 window 上
const sy = new SYBridge();
window[namespace] = sy;
// 需要把实例名告诉 app，目的是让 app 可以调用到 sy 这个实例中的方法
sy.env.setEnvironment({
    namespace
});
```



监听 webview 页面生命周期。在 SYBridge 实例下有一个对象 lifecycle 负责处理 webview 的生命周期，这些生命周期方法名必须是下面这些。

```js
sy.lifecycle = {
    // 页面开始加载，viewDidLoad
    onLoad() {
        console.log('on load');
    },
    // 页面显示，viewDidAppear
    onShow() {
        console.log('on show');
    },
    // 页面消失
    onHide() {
        console.log('on hide');
    },
    // 页面被销毁
    onUnload() {
        console.log('on unload');
    }
};
```



使用默认提供的 api 在 app 内显示一个弹窗：

```js
sy.system.showModal({
    title: 'SYWebViewBridge',
    content: 'An iOS modern bridge for sending messages between Objective-C and JavaScript in WKWebView.',
    showCancel: true,
    cancelText: 'Cancel',
    confirmText: 'OK',
    // 用户点击了 ok 或 cancel 按钮后的回调
    success: function(res) {
        if (res.confirm) {
            console.log('click OK button');
        }
        else {
            console.log('click Cancel button');
        }
    },
    // 失败
    fail: function(err) {
        console.log(err);
    },
    // 成功或失败都会调用
    complete: function(res) {
        console.log(res);
    }
});
```

调试，可以在 app 内进行打印日志，弹窗

```js
// 在 app 内打印日志
sy.debug.log('I am log msg from webview');
// 在 app 内显示一个提示弹窗
sy.debug.alert('receive a debug msg');
```

扩展 bridge api
业务方比较灵活多变，需要支持插件机制让不同的业务可以进行分模块处理，这样不会导致一个文件中出现过多的代码，难以维护。SYWebViewBridge 提供了强大的插件机制，任意扩展。下面我们创建一个 NetworkPlugin，利用 app 发起网络请求。定义的 bridge 名字为 request。

```js
import SYPlugin from 'sy-webview-bridge';

export default class NetworkPlugin extends SYPlugin {
    request(options) {
        this.core.sendMsg(this.router('request'), options);
    }
}
```
插件在使用之前需要进行注册：

```js
const sy = new SYBridge();
// 创建 plugin，第一参数为 sy 实例中的 core 属性，network 为模块名字
let requestPlugin = new NetworkPlugin(sy.core, 'network');
sy.registerPlugin(requestPlugin);
```

# iOS 端使用

iOS 中提供了 `SYHybridWebViewController` 和 `SYHybridWebView`这两种方式：

方式一： `SYHybridWebViewController` 

```objective-c
SYHybridWebViewController *viewController = [[SYHybridWebViewController alloc] init];
[viewController loadUrl:@"http://localhost:9000/home.html"];
[self.navigationController pushViewController:viewController animated:YES];
```

方式二： `SYHybridWebView`

```objc
WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
SYHybridWebView *webview = [[SYHybridWebView alloc] initWithFrame:self.view.bounds configuration:conf];
[self.view addSubview:webview];
```

目前默认有 SYBridgeDebugPlugin 和 SYBridgeSystemPlugin ，你可以添加自己的 plugin 来扩充 bridge，我们以添加 network plugin 为例，前端页面通过 app 来发起网络请求：

`SYBridgeBasePlugin.h`

自定义 plugin 必须继承自 `SYBridgeBasePlugin`

```objc
@interface SYNetworkPlugin : SYBridgeBasePlugin

@end
```

`SYBridgeBasePlugin.m`

该 plugin 中提供了一个方法`request:callback:`，当 App 接收到 webview 发来的消息后，将会自动调用该方法。在 callback block

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
                    @"cbtype": @"success",
                    @"data": dict ?: @{}
                }, msg);
            }
            else {
                callback(@{
                    @"cbtype": @"fail"
                }, msg);
            }
        });
    }];
    [task resume];
}

@end
```

