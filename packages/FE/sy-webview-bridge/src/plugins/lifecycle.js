/**
 * @description lifecycle message
 * @file debug.js
 * @author suyan
*/

import SYPlugin from './plugin';

export default class SYLifeCycle extends SYPlugin {
    // page on load, before onShow (viewDidLoad in iOS)
    onLoad(options = {}) {
        // NA need send message to webview through this function
    }
    // page on show (viewDidAppear in iOS)
    onShow() {
        // NA need send message to webview through this function
    }
    // app enter background
    onHide() {
        // NA need send message to webview through this function
    }
    // page destory (dealloc in iOS)
    onUnload() {
        // NA need send message to webview through this function
    }
    // page scroll
    onPageScroll() {
        // NA need send message to webview through this function
    }
    // page scroll to bottom
    onReachBottom() {
        // NA need send message to webview through this function
    }
}