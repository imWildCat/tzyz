var webpack = require('webpack');

// Reference: https://github.com/petehunt/webpack-howto#6-feature-flags
var definePlugin = new webpack.DefinePlugin({
    __DEV__: JSON.stringify(JSON.parse(process.env.BUILD_DEV || 'true')),
    __PRERELEASE__: JSON.stringify(JSON.parse(process.env.BUILD_PRERELEASE || 'false'))
});

module.exports = {
    //context: __dirname,
    entry: './app/assets/javascripts/app/entry.js',
    output: {
        path: './app/assets/javascripts/app',
        filename: 'bundle.js',
        //devtoolModuleFilenameTemplate: '[resourcePath]',
        //devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]'
    },
    module: {
        loaders: [
            //{
            //    test: /\.jsx$/,
            //    exclude: /(node_modules|bower_components)/,
            //    loader: 'babel-loader'
            //}
            //{test: /\.jsx$/, exclude: /node_modules/, loader: 'babel-loader'},
            //{test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader'},

            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel-loader',
                query: {stage: 0}
            }

            // Next 2 lines expose jQuery and $ to any JavaScript files loaded after client-bundle.js
            // in the Rails Asset Pipeline. Thus, load this one prior.
            //{test: require.resolve('jquery'), loader: 'expose?jQuery'},
            //{test: require.resolve('jquery'), loader: 'expose?$'}
        ]
    },
    resolve: {
        // you can now require('file') instead of require('file.coffee')
        extensions: ['', '.js', '.json', '.jsx']
    },
    plugins: [definePlugin]
};

// http://kevinold.com/2015/02/04/configure-webpack-dev-server-and-react-hot-loader-with-ruby-on-rails.html