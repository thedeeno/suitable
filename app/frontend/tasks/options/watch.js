module.exports = {
  css: {
    files: '**/*.scss',
    tasks: ['assets-css'],
    options: {
      livereload: true,
    },
  },
  js: {
    files: 'assets/scripts/**/*.js',
    tasks: ['assets-js'],
    options: {
      livereload: true,
    },
  },
};
