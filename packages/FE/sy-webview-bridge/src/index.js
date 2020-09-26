/**
 * @description main
 * @author suyan
*/

import SYCore from './core';
import SYSystem from './plugins/system';
import SYDebug from './plugins/debug';
import SYLifeCycle from './plugins/lifecycle';
import SYEnv from './plugins/env';

export class SYMessage {
    constructor(router) {
        this.router = router;
        this.scheme = null;
        this.identifier = null;
        this.module = null;
        this.action = null;
        this.param = null;
        this.parseRouter(router);
    }
    // suyan://com.sy.bridge/debug/showAlert?param={key: value}&callback=js_callback
    parseRouter(router) {
        try {
            let components = router.split('?');
            if (components.length > 2) {
                // router can only have one ?
                return;
            }
            let first = components[0];
            let hostComponents = first.split('://');
            this.scheme = hostComponents[0];
            let pathComponents = hostComponents[1].split('/');
            this.identifier = pathComponents[0];
            this.module = pathComponents[1];
            this.action = pathComponents[2];
            if (components.length < 2) {
                return;
            }
            let second = components[1];
            let queryComponents = second.split('&');
            let params = {};
            queryComponents.forEach(element => {
                let es = element.split('=');
                if (es[0] === 'param') {
                    let jsonObj = JSON.parse(es[1]);
                    params[es[0]] = jsonObj;
                }
                else {
                    params[es[0]] = es[1];
                }
            });
            this.param = params;
        } catch (error) {
            return;
        }
    }
}

export default class SYBridge {
    constructor(options = {}) {
        this.env = this.initEnv(null, options);
        this.core = new SYCore(this.env);
        this.system = new SYSystem(this.core, 'sysystem');
        this.debug = new SYDebug(this.core, 'sydebug');
        this.env = new SYEnv(this.core, 'syenv');
        this.lifecycle = null;
        // private
        this._lifecycle = new SYLifeCycle(this.core, '_sylifecycle', this.lifecycle);
    }
    initEnv(ua, options) {
        if (!ua) {
            ua = navigator && navigator.userAgent;
        }
        if (!ua) {
            return;
        }
        const {
            scheme = 'suyan',
            bundleId = 'com.sy.bridge'
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
            this._lifecycle.proxy = value;
        }
    }
    registerPlugin(plugin, options = {}) {
        if (!plugin) {
            if (__DEV__) {
                console.error('[sybridge] plugin can not be undefined');
            }
            return;
        }
        let pluginName = options.name;
        if (!pluginName) {
            pluginName = plugin.name;
        }
        this[pluginName] = plugin;
    }
    syBridgeMessage(router) {
        // the router like below:
        // suyan://com.sy.bridge/_lifecycle/onShow
        console.log('receive action: ');
        console.log(router);
        let message = new SYMessage(router);
        if (!message) {
            return;
        }
        let actionFn = this[message.module][message.action];
        if (actionFn) {
            actionFn.call(this[message.module], message);
        }
    }

}
