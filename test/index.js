// test/index.js
// require all test files using special Webpack feature
// https://webpack.github.io/docs/context.html#require-context
var testsContext = require.context('./spec', true, /\.spec.coffee$/)
testsContext.keys().forEach(testsContext)
