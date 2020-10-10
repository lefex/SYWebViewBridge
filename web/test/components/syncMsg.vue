<template>
    <div class="sync-msg-wrap">
        <!-- Set Environment -->
        <h1 class="title">Test Set Environment</h1>
        <p class="des">send to app and get a success callback</p>
        <div class="button" v-on:click="setEnvironment">Set Environment</div>
        <test-result :status="setEnvStatus"></test-result>
        <div class="line"></div>
        <!-- showModal -->
        <h1 class="title">Test Use showModal</h1>
        <p class="des">test showModal and get a callback when user click OK or Cancel button</p>
        <div class="button" v-on:click="showModal">ShowModal</div>
        <test-result :status="showModalStatus"></test-result>
        <div class="line"></div>
        <!-- network request -->
        <h1 class="title">Test Network Request</h1>
        <p class="des">send network request in app</p>
        <div class="button" v-on:click="sendRequest">Send Network Request</div>
        <test-result :status="networkStatus"></test-result>
        <div class="line"></div>
        <!-- debug -->
        <h1 class="title">Test Debug</h1>
        <p class="des">send debug msg between app and webview</p>
        <p class="des">Make sure have a debug alert</p>
        <div class="button" v-on:click="alert">Send Debug Alert</div>
        <p class="des">Make sure have a log message in app</p>
        <div class="button" v-on:click="log">Log msg in app</div>
        <p class="des">Make sure have a debug alert</p>
        <div class="button" v-on:click="webAlert">Use Web Alert</div>
    </div>
</template>

<script>
/* global sy */
import TestResult from './testResult.vue';

export default {
    components: {
        TestResult
    },
    data() {
        return {
            setEnvStatus: '0',
            showModalStatus: '0',
            networkStatus: '0'
        };
    },
    methods: {
        setEnvironment() {
            this.setEnvStatus = '0';
            sy.env.setEnvironment({
                namespace: 'sy',
                success: () => {
                    this.setEnvStatus = '1';
                },
                fail: () => {
                    this.setEnvStatus = '2';
                }
            });
            setTimeout(() => {
                if (this.setEnvStatus === '0') {
                    this.setEnvStatus = '2';
                }
            }, 1000);
        },
        alert() {
            sy.debug.alert('receive a debug msg');
        },
        webAlert() {
            alert('webview alert');
        },
        log() {
            sy.debug.log('I am log msg from webview');
        },
        showModal() {
            this.showModalStatus = '0';
            sy.system.showModal({
                title: 'SYWebViewBridge',
                content: 'An iOS modern bridge for sending messages between Objective-C and JavaScript in WKWebView.',
                showCancel: true,
                cancelText: 'Cancel',
                confirmText: 'OK',
                success: res => {
                    if (res.confirm) {
                        sy.debug.alert('click OK button');
                    }
                    else {
                        sy.debug.alert('click Cancel button');
                    }
                    this.showModalStatus = '1';
                },
                fail: err => {
                    this.showModalStatus = '2';
                }
            });
            setTimeout(() => {
                if (this.showModalStatus === '0') {
                    this.showModalStatus = '2';
                }
            }, 10000);
        },
        sendRequest() {
            this.networkStatus = '0';
            sy.network.request({
                url: 'https://www.igetget.com/api/wap/footer',
                method: 'get',
                data: {
                    from: 'SYWebViewBridge'
                },
                header: {
                    'content-type': 'application/json'
                },
                success: res => {
                    sy.debug.alert(res.data);
                    this.networkStatus = '1';
                },
                fail: err => {
                    sy.debug.alert('network error');
                    this.networkStatus = '1';
                },
                complete(res) {
                    this.networkStatus = '1';
                }
            });
            setTimeout(() => {
                if (this.networkStatus === '0') {
                    this.networkStatus = '2';
                }
            }, 5000);
        }
    }
};
</script>

<style scoped>
.line {
    height: 1px;
    background-color: #eee;
    margin-top: 10px;
}
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