# Using SYWebViewBridge(FE)

You can use sy-webview-bridge into you H5 page. run `npm install sy-webview-bridge` to install sy-webview-bridge.

First, you should create an instance of SYBridge and add it to window. So, you can use bridge in the h5 page where you want.

```js
import SYBridge from 'sy-webview-bridge';

// create SYBridge instance and add to window
const namespace = 'sy';
const sy = new SYBridge();
window[namespace] = sy;
```

Second, tell app that the name of SYBridge instance. So, app can call SYBridge instance method.

```js
sy.env.setEnvironment({
    namespace
});
```

## LifeCycle

You can observe the H5 page lifecycle.

```js
sy.lifecycle = {
    onShow() {
        // web page appear
    },
    onHide() {
        // web page disappear
    },
    onUnload() {
        // web page dealloc
    }
};
```

## A bridge api

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

## Debug in webview

You can console log a message in app:

```js
sy.debug.log('I am log msg from webview');
```

You can show a alert in app:

```js
sy.debug.alert('receive a debug msg');
```

## Plugin system

`sy-webview-bridge` provide a powerful plugin system. You can write own bridge api through plugin system. We can write a `NetworkPlugin` to send a request in app and get a response from app.

1. create a NetworkPlugin class

`NetworkPlugin` must extend from base class `SYPlugin` and give a request method.

```js
import SYPlugin from 'sy-webview-bridge';

export default class NetworkPlugin extends SYPlugin {
    request(options) {
        this.core.sendMsg(this.router('request'), options);
    }
}
```

2. register

```js
const sy = new SYBridge();
let requestPlugin = new NetworkPlugin(sy.core, 'network');
sy.registerPlugin(requestPlugin);
```

3. use

You can use `sy.network.request` to send a request. The `sy` is instance of SYBridge, `network` is the plugin we create just now.

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

