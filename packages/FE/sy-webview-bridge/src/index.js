class SYBridge {
    constructor() {
        // init
    }
    sendMsg(router, params) {
        const paramJson = JSON.stringify(params);
        let jumpRouter = `${router}&params=${paramJson}`;
        this.callPostMessage(jumpRouter);
    }
    callPostMessage(router) {
        window.webkit.messageHandlers.SYJSBridge.postMessage(router);
    }
    callIframe(router) {
        var iframe = document.createElement('iframe');
        iframe.src = router;
        document.body.appendChild(iframe);
        document.body.removeChild(iframe);
    }
    callLocation(router) {
        window.location.href = router;
    }
    showModal(options) {

    }
}

const sy = new SYBridge();

module.exports = {
    sy
};
