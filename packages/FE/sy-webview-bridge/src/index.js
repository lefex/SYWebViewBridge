/**
 * @file index.js
 * @description main
 * @author suyan
*/

/* global __SYDEV__ */

// send message between webview and app
import SYCore from './core';
// system plugin
import SYSystem from './plugins/system';
// debug plugin
import SYDebug from './plugins/debug';
// lifecycle plugin
import SYLifeCycle from './plugins/lifecycle';
// environment plugin
import SYEnv from './plugins/env';
import {SYDefaultScheme, SYDefaultIdentifier} from './constant';
// bridge will log some useful messages when in devlopment environment
window.__SYDEV__ = true;

// change router to SYMessage Class
export class SYMessage {
    constructor(router) {
        // orgin router like suyan://com.sy.bridge/debug/showModal?param={key: value}&callback=js_cb
        this.router = router;
        // eg. router is: suyan://com.sy.bridge/debug/showModal?param={key: value}&callback=js_cb
        // router scheme, eg: suyann
        this.scheme = null;
        // can you app bundle id, eg: com.sy.bridge
        this.identifier = null;
        // bridge in which moduleName, eg: debug
        this.moduleName = null;
        // bridge in which action, eg: showModal
        this.action = null;
        // the action method param
        this.param = null;
        // parse router to SYMessage Object
        let isValid = this.parseRouter(router);
        if (!isValid) {
            if (__SYDEV__) {
                console.log('right router such as: suyan://com.sy.bridge/debug/showModal?param={key: value}&callback=js_cb');
            }
            throw 'the router is invalid: ' + router;
        }
    }
    // suyan://com.sy.bridge/debug/showModal?param={key: value}&callback=js_callback
    parseRouter(router) {
        try {
            let components = router.split('?');
            if (components.length > 2) {
                // router can only have one ?
                return false;
            }
            let first = components[0];
            let hostComponents = first.split('://');
            this.scheme = hostComponents[0];
            let pathComponents = hostComponents[1].split('/');
            this.identifier = pathComponents[0];
            this.moduleName = pathComponents[1];
            this.action = pathComponents[2];
            if (components.length < 2) {
                // have no query
                return true;
            }
            let second = components[1];
            let queryComponents = second.split('&');
            let params = {};
            queryComponents.forEach(element => {
                let es = element.split('=');
                if (es[0] === 'params') {
                    let decodeStr = decodeURIComponent(es[1]);
                    let jsonObj = JSON.parse(decodeStr);
                    params[es[0]] = jsonObj;
                }
                else {
                    params[es[0]] = es[1];
                }
            });
            this.param = params;
            return true;
        }
        catch (error) {
            return false;
        }
    }
}

// The main class to deal with bridge message
export default class SYBridge {
    constructor(options = {}) {
        // init webview context
        this.context = this.initContext(null, options);
        // send message core
        this.core = new SYCore(this.context);
        // system plugin, the module moduleName is system
        this.system = new SYSystem(this.core, 'system');
        // debug plugin
        this.debug = new SYDebug(this.core, 'debug');
        // environment plugin
        this.env = new SYEnv(this.core, 'env');
        // lifecycle object to receive lifecycle message
        this.lifecycle = null;
        // private
        this._lifecycle = new SYLifeCycle(this.core, '_lifecycle', this.lifecycle);
    }
    initContext(ua, options) {
        if (!ua) {
            ua = navigator && navigator.userAgent;
        }
        if (!ua) {
            return;
        }
        const {
            scheme = SYDefaultScheme,
            bundleId = SYDefaultIdentifier
        } = options;
        const env = {
            isAndroid: /(Android);?[\s/]+([\d.]+)?/.test(ua),
            isIOS: !!ua.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),
            inNA: /-SYBridge-/i.test(ua),
            scheme,
            bundleId
        };
        return env;
    }
    set lifecycle(value) {
        if (value) {
            // set the lifecycle proxy to receive message
            this._lifecycle.proxy = value;
        }
    }
    // add a custom plugin to SYBridge
    registerPlugin(plugin, options = {}) {
        if (!plugin) {
            if (__SYDEV__) {
                console.error('[sybridge] plugin can not be undefined');
            }
            return;
        }
        let pluginName = options.moduleName;
        if (!pluginName) {
            // use plguin moduleName when provide
            pluginName = plugin.moduleName;
        }
        // add the plugin to bridge instance
        this[pluginName] = plugin;
    }
    // app send message to webview through this method
    syBridgeMessage(router) {
        // the router like below (the webview lifecycle method):
        // suyan://com.sy.bridge/_lifecycle/onShow
        let message = new SYMessage(router);
        if (!message || !message.moduleName || !message.action) {
            return;
        }
        // get the bridge method
        let actionFn = this[message.moduleName][message.action];
        if (actionFn && typeof actionFn === 'function') {
            actionFn.call(this[message.moduleName], message);
        }
        else {
            if (__SYDEV__) {
                console.log('can not get action function: ', actionFn);
            }
        }
    }

}
