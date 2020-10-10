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
        // observe webview lifecycle
        let that = this;
        sy.lifecycle = {
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