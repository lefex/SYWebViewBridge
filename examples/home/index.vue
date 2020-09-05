<template>
    <div id="app">
        <Header></Header>
    </div>
</template>

<script>
import Header from './components/header.vue';

export default {
    components: {
        Header
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