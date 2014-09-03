module.exports = {
  images: {
    files: [{
      expand: true,
      cwd: 'assets/images',
      src: ['*.svg'],
      dest: 'dist/images',
      filter: 'isFile'
    }]
  },
  js: {
    files: [{
      expand: true,
      cwd: 'assets/scripts',
      src: ['**/*.js'],
      dest: 'dist/js'
    }]
  }
};
