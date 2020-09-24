/**
 * @description send message
 * @file core.js
 * @author suyan
*/

export default class SYCore {
    constructor(env) {
        // save callback id and function
        this.callbackMap = {};
        // current callback id
        this.curId = 1;
        // isIOS\isAndroid\isNA
        this.env = env;
    }
    sendMsg(router, options) {
        const params = this.generateParams(options);
        // all param neeed to be a json string
        const paramJson = JSON.stringify(params);
        // generate a router
        let jumpRouter = `${router}?params=${paramJson}`;
        if (this.env.isAndroid) {
             // use prompt to send message in Android
            prompt(jumpRouter);
        }
        else {
             // use postMessage to send message in iOS
            this.callPostMessage(jumpRouter);
        }
        // need to change callback id(due to not repeat)
        this.curId += 1;
    }
    callPostMessage(router) {
        window.webkit.messageHandlers.SYJSBridge.postMessage(router);
    }
    callIframe(router) {
        var iframe = document.createElement('iframe');
        iframe.src = router;
        document.body.appendChild(iframe);
        document.body.removeChild(iframe);
    }
    callLocation(router) {
        window.location.href = router;
    }
    generateParams(options) {
        // send NA params
        let params = {};
        let callbackId = this.curId;
        Object.keys(options).forEach(key => {
            if (typeof options[key] === 'function') {
                let callback = this.callbackMap[callbackId];
                if (!callback) {
                    callback = {};
                    this.callbackMap[callbackId] = callback;
                }
                // success fail complete
                callback[key] = options[key];
            }
            else {
                params[key] = options[key];
            }
        });
        params['callbackId'] = callbackId;
        return params;
    }
    // the default callback function, app will call this
    sendCallback(options) {
        if (!options || !options.callbackId) {
            if (__DEV__) {
                console.error('[sybridge] options must contain a callbackId');
            }
            return;
        }
        const callbackId = options.callbackId;
        const callbackObj = this.callbackMap[callbackId];
        if (!callbackObj) {
            // can not found callback fun
            if (__DEV__) {
                console.error('[sybridge] callbackId invalid');
            }
            return;
        }
        const cbIsValid = ['success', 'fail', 'complete'].indexOf(options.cbtype) !== -1;
        if (!options.cbtype || !cbIsValid) {
            if (__DEV__) {
                console.error('[sybridge] cbtype only support success、fail and complete');
            }
        }
        const cbFun = callbackObj[options.cbtype];
        if (!cbFun || typeof cbFun !== 'function') {
            // not have callback function
            return;
        }
        cbFun(options);
        // call complete function
        const completeFun = callbackObj['complete'];
        if (completeFun && typeof completeFun === 'function') {
            // need call complete function no matter success or fail
            completeFun(options);
        }
        // callback end need delete map cache
        delete this.callbackMap[callbackId];
        if (this.callbackMap || Object.keys(this.callbackMap).length === 0) {
            this.curId = 1;
        }
    }
}
