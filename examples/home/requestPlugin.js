/**
 * @description network request
 * @file requestPlugin.js
 * @author suyan
*/

import SYPlugin from '../../packages/FE/sy-webview-bridge/src/plugins/plugin';

export default class RequestPlugin extends SYPlugin {
    request(options) {
        this.core.sendMsg(this.router('request'), options);
    }
}
