<template>
    <div id="app">
        <Header></Header>
        <SyncMsg></SyncMsg>
    </div>
</template>

<script>
/* global sy */
import Header from './components/header.vue';
import SyncMsg from './components/syncMsg.vue';
import SYBridge from '../../packages/sy-webview-bridge/dist/index.js';
import NetworkPlugin from './networkPlugin';

export default {
    components: {
        Header,
        SyncMsg
    },
    data() {
        return {
            title: 'SYWebViewBridge1'
        };
    },
    mounted() {
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
        // observe webview lifecycle
        sy.lifecycle = {
            onLoad() {
                console.log('on load');
            },
            onShow() {
                console.log('on show');
            },
            onHide() {
                console.log('on hide');
            },
            onUnload() {
                console.log('on unload');
            }
        };
    }
};
</script>

<style scoped>
#app {
    padding: 16px;
}
</style>