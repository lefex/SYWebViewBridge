<template>
    <div class="sync-msg-wrap">
        <!-- lifeCycle -->
        <h1 class="title">Set Environment</h1>
        <p class="des">send some messages to app before bridge work</p>
        <div class="button" v-on:click="setEnvironment">Set Environment</div>
        <!-- showModal -->
        <h1 class="title">Use showModal</h1>
        <p class="des">the demo of showModal</p>
        <div class="button" v-on:click="showModal">ShowModal</div>
        <!-- lifeCycle -->
        <h1 class="title">LifeCycle message</h1>
        <p class="des">the webview lifecycle</p>
        <!-- network request -->
        <h1 class="title">Network Request</h1>
        <p class="des">send network request in app</p>
        <div class="button" v-on:click="sendRequest">Send Network Request</div>
        <!-- debug -->
        <h1 class="title">Debug</h1>
        <p class="des">send debug msg between app and webview</p>
        <div class="button" v-on:click="alert">Send Debug Alert</div>
        <div class="button" v-on:click="log">Log msg in app</div>
    </div>
</template>

<script>
/* global sy */
export default {
    data() {
        return {
            title: 'Sync msg to Obj-C',
            description: 'WebView send msg to Obj-C and get a return value.',
            result: ''
        };
    },
    methods: {
        setEnvironment() {
            sy.env.setEnvironment({
                namespace: 'wsy'
            });
        },
        alert() {
            // sy.debug.alert('receive a debug msg');
            alert('webview alert');
        },
        log() {
            sy.debug.log('I am log msg from webview');
        },
        showModal() {
            sy.system.showModal({
                title: 'SYWebViewBridge',
                content: 'An iOS modern bridge for sending messages between Objective-C and JavaScript in WKWebView.',
                showCancel: true,
                cancelText: 'Cancel',
                confirmText: 'OK',
                success(res) {
                    if (res.confirm) {
                        console.log('click OK button');
                        sy.debug.alert('click OK button');
                    }
                    else {
                        console.log('click Cancel button');
                        sy.debug.alert('click Cancel button');
                    }
                },
                fail(err) {
                    console.log(err);
                },
                complete(res) {
                    console.log(res);
                }
            });
        },
        sendRequest() {
            sy.network.request({
                url: 'https://www.igetget.com/api/wap/footer',
                method: 'get',
                data: {
                    from: 'SYWebViewBridge'
                },
                header: {
                    'content-type': 'application/json'
                },
                success(res) {
                    console.log('get request result: ', res.data);
                    sy.debug.alert(res.data);
                },
                fail(err) {
                    console.error('request error');
                    sy.debug.alert('network error');
                },
                complete(res) {
                    console.log('request complete');
                }
            });
        }
    }
};
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
    cursor: pointer;
}
.button:hover {
    background-color: #1191FF;
}
</style>