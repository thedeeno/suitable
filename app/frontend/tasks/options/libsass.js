module.exports = {
  libsass: {
    options: {
      loadPath: ['my/load/path']
    },
    files: [{
      expand: true,
      cwd: 'assets/styles',
      src: ['application.scss'],
      dest: 'dist/css',
      ext: '.css'
    }]
  }
};
