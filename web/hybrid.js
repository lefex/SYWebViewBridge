import SYBridge from '../packages/sy-webview-bridge/src/index.js';
import NetworkPlugin from './networkPlugin';

export default function initBridge() {
    // set the namespace sy
    const namespace = 'sy';
    // add bride object to window
    const sy = new SYBridge();
    window[namespace] = sy;
    // tell app that my namespace is sy
    sy.env.setEnvironment({
        namespace
    });
    // add custom plugin
    let requestPlugin = new NetworkPlugin(sy.core, 'network');
    sy.registerPlugin(requestPlugin);
};