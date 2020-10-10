/**
 * @description network request
 * @file requestPlugin.js
 * @author suyan
*/

import {SYPlugin} from '../../packages/sy-webview-bridge/dist/index';

export default class NetworkPlugin extends SYPlugin {
    request(options) {
        this.core.sendMsg(this.router('request'), options);
    }
}
