const sendMsg = function (msg) {
    console.log('send msg:', msg);
    window.webkit.messageHandlers.SYJSBridge.postMessage(msg);
};

const callIframe = function(url) {
    var iframe = document.createElement('iframe');
    iframe.src = url;
    document.body.appendChild(iframe);
    document.body.removeChild(iframe);
}

const callLocation = function (url) {
    window.location.href = url;
}

module.exports = {
    sendMsg,
    callIframe,
    callLocation
};
