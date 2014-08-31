module.exports = function(grunt) {
  var path = require('path');

  require('load-grunt-config')(grunt, {
    init: true, //auto grunt.initConfig
    configPath: path.join(process.cwd(), 'tasks/options')
  });

  require('load-grunt-tasks')(grunt);
}
