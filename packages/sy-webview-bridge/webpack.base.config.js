/**
 * @file webpack prod config for sybridge
 * @author suyan
 */


module.exports = {
    entry: {
        sybridge: __dirname + '/src/index.js'
    },
    output: {
        path: __dirname + '/dist',
        filename: '[name]/index.js',
        libraryTarget: 'umd'
    },
    module: {
        rules: [{
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel-loader',
                query: {
                    presets: ['env'],
                    plugins: [
                        'transform-class-properties',
                        ['transform-object-rest-spread', {
                            useBuiltIns: true
                        }],
                        'transform-decorators-legacy',
                        'transform-object-assign'
                    ]
                }
            }]
    }
};

