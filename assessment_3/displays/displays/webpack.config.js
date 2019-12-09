import webpack from 'webpack';
import path from 'path';
import qs from 'querystring';

process.env.NODE_ENV = process.env.NODE_ENV || "development";

export default {
  mode: process.env.NODE_ENV,
  devtool: '#eval-source-map',
  entry: [
    'webpack-hot-middleware/client',
    './client/app.js'
  ],
  output: {
    path: __dirname,
    filename: 'bundle.js',
    publicPath: '/'
  },
  plugins: [
    new webpack.optimize.OccurrenceOrderPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoEmitOnErrorsPlugin(),
    new webpack.EnvironmentPlugin({
      'DISPLAY_HOST': JSON.stringify(process.env.DISPLAY_HOST),
      'DISPLAY_PORT': JSON.stringify(process.env.DISPLAY_PORT),
    }),
  ],
  resolve: {
    extensions: ['.js'],
    alias: {
      request: 'browser-request'
    }
  },
  module: {
    rules: [
      // Javascript
      {
        test: /\.js$/,
        loader: 'babel-loader',
        include: path.join(__dirname, 'client'),
      },
      {
        test: /\.scss$/,
        loaders: ['style-loader', 'css-loader', 'sass-loader']
      },
    ]
  }
};
