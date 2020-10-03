在 App 开发当中，Hybrid 框架发展越来越成熟， webview 和 App 进行通信只是最基本的功能，现如今对 Hybrid 框架要求越来越高。比如小程序框架，其实也可以把它看做是一个 Hybrid 框架。我认为一个好的 Hybrid 框架需要支持下面这些特性：

1、webview 与 iOS、Android App 可进行无差别通信；

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



## 如何使用



### 初始化（前端）

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

