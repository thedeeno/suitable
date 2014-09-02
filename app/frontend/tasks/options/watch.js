module.exports = {
  css: {
    files: '**/*.scss',
    tasks: ['assets-css'],
    options: {
      livereload: true,
    },
  },
  "js:local": {
    files: 'assets/scripts/**/*.js',
    tasks: ['assets-js-local'],
    options: {
      livereload: true,
    },
  },
  "js:vendor": {
    files: 'tasks/options/bower_concat.js',
    tasks: ['assets-js-vendor'],
    options: {
      livereload: true,
    },
  },
};
