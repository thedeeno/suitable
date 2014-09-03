module.exports = {
  all: {
    dest: 'dist/js/vendor.js',
    dependencies: {
      'backbone': ['underscore','jquery'],
      'underscore': 'jquery',
    }
  }
}
