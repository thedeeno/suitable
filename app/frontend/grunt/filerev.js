module.exports = function(config) {
  return {
    options: {
      encoding: 'utf8',
      algorithm: 'md5',
      length: 8
    },
    styles: {
      src: 'dist/css/**/*.css'
    }
  }
};
