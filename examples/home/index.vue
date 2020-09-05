<template>
    <div id="app">
        <Header></Header>
        <SyncMsg></SyncMsg>
    </div>
</template>

<script>
import Header from './components/header.vue';
import SyncMsg from './components/syncMsg.vue';

export default {
    components: {
        Header,
        SyncMsg
    },
    data() {
        return {
            title: 'SYWebViewBridge1'
        }
    }
}
</script>

<style scoped>
#app {
    padding: 16px;
}
</style>