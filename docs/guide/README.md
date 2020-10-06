# Introduction

An iOS *modern bridge* for sending messages between Objective-C and JavaScript in WKWebView. You can use in H5 and iOS. The bridge api like below:

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
    }
});
```