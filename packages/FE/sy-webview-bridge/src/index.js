const sendMsg = function (msg) {
    console.log('send msg');
    window.webkit.messageHandlers.SYJSBridge.postMessage(JSON.stringify(msg));
};

module.exports = {
    sendMsg
};
