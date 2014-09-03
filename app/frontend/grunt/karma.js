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
        singleRun: true,

        logLevel: 'ERROR',

        browsers: ['Firefox']
      }
    }
  };
};
