/**
 * @description the plugin
 * @file plugin.js
 * @author suyan
*/

export default class SYPlugin {
    constructor(core, module) {
        this.core = core;
        this.module = module;
    }
    // generate a router
    router(action) {
        let env = this.core.env;
        let aRouter = `${env.scheme}://${env.bundleId}/${this.module}/${action}`;
        return aRouter;
    }
}