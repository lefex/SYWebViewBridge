/**
 * @description lifecycle message
 * @file debug.js
 * @author suyan
*/

import SYPlugin from './plugin';

export default class SYLifeCycle extends SYPlugin {
    constructor(core, moduleName, proxy) {
        super(core, moduleName);
        this.proxy = proxy;
    }
    // page on load, before onShow (viewDidLoad in iOS)
    onLoad(msg) {
        // NA need send message to webview through this function
        if (this.isValid('onLoad')) {
            this.proxy.onLoad.call(this.proxy, msg);
        }
    }
    // page on show (viewDidAppear in iOS)
    onShow(msg) {
        // NA need send message to webview through this function
        if (this.isValid('onShow')) {
            this.proxy.onShow.call(this.proxy, msg);
        }
    }
    // app enter background
    onHide(msg) {
        // NA need send message to webview through this function
        if (this.isValid('onHide')) {
            this.proxy.onHide.call(this.proxy, msg);
        }
    }
    // page destory (dealloc in iOS)
    onUnload(msg) {
        // NA need send message to webview through this function
        if (this.isValid('onUnload')) {
            this.proxy.onUnload.call(this.proxy, msg);
        }
    }
    // page scroll
    onPageScroll(msg) {
        // NA need send message to webview through this function
        if (this.isValid('onPageScroll')) {
            this.proxy.onPageScroll.call(this.proxy, msg);
        }
    }
    // page scroll to bottom
    onReachBottom(msg) {
        // NA need send message to webview through this function
        if (this.isValid('onReachBottom')) {
            this.proxy.onReachBottom.call(this.proxy, msg);
        }
    }
    // if the proxy is valid
    isValid(method) {
        if (this.proxy && this.proxy[method] && typeof this.proxy[method] === 'function') {
            return true;
        }
        return false;
    }
}