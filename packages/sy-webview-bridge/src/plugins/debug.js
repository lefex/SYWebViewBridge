/**
 * @description debug message
 * @file debug.js
 * @author suyan
*/

import SYPlugin from './plugin';

// debug plugin
export default class SYDebug extends SYPlugin {
    // show a toast in app
    alert(msg) {
        this.core.sendMsg(this.router('alert'), {
            title: 'debug message',
            content: this.debugMsg(msg)
        });
    }
    // log msg in app log pannel
    log(msg) {
        this.core.sendMsg(this.router('log'), {
            msg: this.debugMsg(msg)
        });
    }
    // generate a debug msg
    debugMsg(msg) {
        let logInfo;
        if (typeof msg === 'string') {
            logInfo = msg;
        }
        else {
            try {
                logInfo = JSON.stringify(msg);
            }
            catch (error) {
                logInfo = 'the msg invalid, can not use';
            }
        }
        return logInfo;
    }
}
