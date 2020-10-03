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
import SYBridge from '../../packages/FE/sy-webview-bridge/src/index.js';

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