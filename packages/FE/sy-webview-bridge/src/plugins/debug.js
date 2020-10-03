/**
 * @description debug message
 * @file debug.js
 * @author suyan
*/

import SYPlugin from './plugin';

export default class SYDebug extends SYPlugin {
    alert(msg) {
        this.core.sendMsg(this.router('alert'), {
            title: 'debug message',
            content: this.debugMsg(msg)
        });
    }
    log(msg) {
        this.core.sendMsg(this.router('log'), {
            msg: this.debugMsg(msg)
        });
    }
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
