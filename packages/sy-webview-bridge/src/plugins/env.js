/**
 * @description environment message
 * @file env.js
 * @author suyan
*/

import SYPlugin from './plugin';
import {SYEnvBridgeName} from '../constant';

export default class SYEnv extends SYPlugin {
    setEnvironment(options) {
        options.bridgeName = SYEnvBridgeName;
        this.core.sendMsg(this.router('setEnv'), options);
    }
}
