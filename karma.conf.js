// we can just use the exact same webpack config by requiring it
// however, remember to delete the original entry since we don't
// need it during tests
var webpackConfig = require('./webpack.config.js')
delete webpackConfig.entry

module.exports = function (config) {
  config.set({
    browsers: ['PhantomJS'],
    frameworks: ['jasmine'],
    files: ['test/index.js'],
    //reporters: ['spec'],
    preprocessors: {
      'test/index.js': ['webpack']
    },
    singleRun: true,
    webpack: webpackConfig,
    webpackMiddleware: {
      noInfo: true
    },
    entry: {
      app: [
        'babel-polyfill',
        './src/main.js'
      ]
    },
    client: {
      captureConsole: true,
    },
    //logLevel: config.LOG_INFO
  })
}
