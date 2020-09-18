<template>
    <div class="sync-msg-wrap">
        <h1 class="title">{{ title }}</h1>
        <p class="des">{{ description }}</p>
        <div v-if="result" class="result">
            <p>get result:</p>
            <p>{{ result }}</p>
        </div>
        <div class="button" v-on:click="getAppVersion">Get App Version</div>
    </div>
</template>

<script>
import { sendMsg, callIframe, callLocation } from '../../../packages/FE/sy-webview-bridge/src/index.js';

export default {
    data() {
        return {
            title: 'Sync msg to Obj-C',
            description: 'WebView send msg to Obj-C and get a return value.',
            result: ''
        }
    },
    methods: {
        getAppVersion() {
            console.log('get app version');
            var msg = {"title": "suyan", "content":"webview bridge"};
            var msgJson = JSON.stringify(msg);
            console.log(msgJson);
            sendMsg("suyan://gzh.fe/sydebug/alert?params=" + msgJson + "&callback=jscb&upgrade=1");
            // callIframe('suyan-iframe');
            // callLocation('suyan-location');
            // console.log(add(10, 11));
        }
    }
}
</script>

<style scoped>
.sync-msg-wrap {
    border-bottom: 1px solid #eee;
}
.title {
    font-size: 24px;
    font-weight: 700;
}
.des {
    font-size: 16px;
}
.result {
    border: 1px solid #eee;
    padding: 8px;
}
.button {
    height: 44px;
    border: 1px solid #eee;
    background-color: #0091FF;
    color: #fff;
    text-align: center;
    font-size: 18px;
    line-height: 44px;
    font-weight: 700;
    border-radius: 8px;
    margin: 16px 0;
}
</style>