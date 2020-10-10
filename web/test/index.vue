<template>
    <div id="app">
        <Header></Header>
        <SyncMsg></SyncMsg>
        <!-- lifeCycle -->
        <h1 class="title">Test LifeCycle message</h1>
        <p class="des">the webview lifecycle</p>
        <div v-for="title in lifecycles">{{ title }}</div>
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
            title: 'SYWebViewBridge1',
            lifecycles: []
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
        let that = this;
        sy.lifecycle = {
            onLoad() {
                that.lifecycles.push('onLoadd');
            },
            onShow() {
                that.lifecycles.push('onShow');
            },
            onHide() {
                that.lifecycles.push('onHide');
            },
            onUnload() {
                that.lifecycles.push('onUnload');
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