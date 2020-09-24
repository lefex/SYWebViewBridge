/**
 * @description main
 * @author suyan
*/

import SYCore from './core';
import SYSystem from './plugins/system';
import SYDebug from './plugins/debug';
import SYLifeCycle from './plugins/lifecycle';

export default class SYBridge {
    constructor(options = {}) {
        this.env = this.initEnv(null, options);
        this.core = new SYCore(this.env);
        this.system = new SYSystem(this.core, 'sysystem');
        this.debug = new SYDebug(this.core, 'sydebug');
        this.lifecycle = new SYLifeCycle(this.core, 'sylifecycle');
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
            bundleId = 'gzh.fe'
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
}
