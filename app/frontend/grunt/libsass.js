module.exports = {
  libsass: {
    options: {
      loadPath: ['bower_components/foundation/scss']
    },
    files: [{
      expand: true,
      cwd: 'assets/styles',
      src: ['application.scss', 'components.scss'],
      dest: 'dist/css',
      ext: '.css'
    }]
  }
};
