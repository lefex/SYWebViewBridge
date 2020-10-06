---
home: true
heroImage: https://upload-images.jianshu.io/upload_images/1664496-1471f633bfc7d877.png
heroText: Subcribe My WeChat Account
tagline: An iOS modern bridge for sending messages between Objective-C and JavaScript in WKWebView. Include FE and iOS.
actionText: Quick Start →
actionLink: /guide/
features:
- title: iOS Hybrid WebView
  details: Suppert WKWebView in iOS. Send message between iOS and web pages.
- title: FE JS-Native
  details: Support many ways to send message to iOS app and get callback.
- title: Base Router
  details: Use router to send message, like open an URL on broswer.
footer: Made by  with suyan wang❤️
---

```js
sy.system.showModal({
    title: 'SYWebViewBridge',
    content: 'An iOS modern bridge for sending messages between Objective-C and JavaScript in WKWebView.',
    showCancel: true,
    cancelText: 'Cancel',
    confirmText: 'OK',
    success: function(res) {
        if (res.confirm) {
            console.log('Click OK button');
        }
        else {
            console.log('Click Cancel button');
        }
    },
    fail: function(err) {
        console.log(err);
    },
    complete: function(res) {
        console.log(res);
    }
});
```
