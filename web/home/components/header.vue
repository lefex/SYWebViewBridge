<template>
    <div class="header-wrap">
        <h1 class="title">{{ title }}</h1>
        <p class="des">{{ description }}</p>
    </div>
</template>

<script>
export default {
    data() {
        return {
            title: 'SYWebViewBridge',
            description: 'An iOS modern bridge for sending messages between Objective-C and JavaScript in WKWebView. Include FE and iOS.'
        }
    }
}
</script>

<style scoped>
.title {
    font-size: 30px;
    font-weight: 700;
}
.des {
    font-size: 16px;
}
</style>