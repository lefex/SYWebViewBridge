<template>
    <div class="sync-msg-wrap">
        <h1 class="title">{{ title }}</h1>
        <p class="des">{{ description }}</p>
        <div v-if="result" class="result">
            <p>get result:</p>
            <p>{{ result }}</p>
        </div>
        <div class="button" v-on:click="alert">Send Debug Alert</div>
        <h1 class="title">Use showModal</h1>
        <p class="des">the demo of showModal</p>
        <div class="button" v-on:click="showModal">showModal</div>
    </div>
</template>

<script>

export default {
    data() {
        return {
            title: 'Sync msg to Obj-C',
            description: 'WebView send msg to Obj-C and get a return value.',
            result: ''
        }
    },
    methods: {
        alert() {
            sy.debug.alert('receive a debug msg');
        },
        showModal() {
            sy.system.showModal({
                title: 'SYWebViewBridge',
                content: 'An iOS modern bridge for sending messages between Objective-C and JavaScript in WKWebView.',
                showCancel: true,
                cancelText: 'Cancel',
                confirmText: 'OK',
                success: function(res) {
                    if (res.confirm) {
                        console.log('click OK button');
                        sy.debug.alert('click OK button');
                    }
                    else {
                        console.log('click Cancel button');
                        sy.debug.alert('click Cancel button');
                    }
                },
                fail: function(err) {
                    console.log(err);
                },
                complete: function(res) {
                    console.log(res);
                }
            });
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