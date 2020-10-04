/**
 * @description the plugin
 * @file plugin.js
 * @author suyan
*/

// plugin base class
export default class SYPlugin {
    constructor(core, moduleName) {
        this.core = core;
        this.moduleName = moduleName;
    }
    // generate a router
    router(action) {
        let env = this.core.context;
        // a router like below
        // suyan://gzh.fe/debug/showAlert?param={key: value}&callback=js_callback
        let aRouter = `${env.scheme}://${env.bundleId}/${this.moduleName}/${action}`;
        return aRouter;
    }
}
