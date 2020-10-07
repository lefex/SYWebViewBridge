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
            title: 'SYWebViewBridge Test Case',
            description: 'The app and webview should be tested at same time. You must test'
                + 'manuly'
        };
    }
};
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