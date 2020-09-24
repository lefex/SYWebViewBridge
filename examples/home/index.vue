<template>
    <div id="app">
        <Header></Header>
        <SyncMsg></SyncMsg>
    </div>
</template>

<script>
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
        }
    },
    mounted() {
        // add sy object to window
        const sy = new SYBridge();
        window['sy'] = sy;
    }
}
</script>

<style scoped>
#app {
    padding: 16px;
}
</style>