const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');

// entry
const entry = {
    home: './home/index.js'
};

// generate html plugins
const plugins = [];
!(function(){
    let keys = Object.keys(entry);
    keys.map(key => {
        let htmlPlugin = new HtmlWebpackPlugin({
            title: 'SYWebViewBridge',
            template: './index.tpl.html',
            chunks: [key],
            filename: `${key}.html`,
            meta: {
                charset: { charset: 'utf-8' },
                viewport: 'width=device-width, initial-scale=1'
            },
            inject: "body",
            favicon: 'favicon.png',
        });
        plugins.push(htmlPlugin);
    });
}());

module.exports = {
    mode: 'development',
    entry: entry,
    output: {
        filename: '[name].js',
        path: path.resolve(__dirname, './dist')
    },
    module: {
        rules: [
            {
                // use vue-loader to deal with vue file
                test: /\.vue$/,
                use: ['vue-loader']
            },
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader']
            }
        ]
    },
    plugins: [
        new VueLoaderPlugin()
    ].concat(plugins),
    devtool: 'source-map',
    devServer: {
        contentBase: path.join(__dirname, 'dist'),
        compress: true,
        port: 9000
    }
}