/**
 * @file webpack config for subridge
 * @author suyan
 */

const baseWebpackConfig = require('./webpack.base.config.js');
const merge = require('webpack-merge');

module.exports = merge(
    baseWebpackConfig,
    {
        mode: 'production',
        optimization: {
            minimize: true
        }
    }
);
