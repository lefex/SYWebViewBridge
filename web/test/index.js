import Vue from 'vue';
import Home from './index.vue';
import initBridge from '../hybrid';

initBridge();

new Vue({
    el: '#app',
    render: h => h(Home)
});
