module.exports = function(config) {
  return {
    unit: {
      options: {
        basePath: '',

        frameworks: ['mocha', 'chai'],

        // 'src/*.js',
        files: [
          'specs/*.spec.js'
        ],

        reporters: ['progress'],

        port: 9876,
        colors: true,
        autoWatch: true,
        singleRun: false,

        // level of logging
        // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
        logLevel: config.LOG_INFO,

        browsers: ['Firefox']
      }
    }
  };
};
