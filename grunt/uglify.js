module.exports = {
  development: {
    options: {
      sourceMap: false,
      beautify: true,
    },
    files: {
      './priv/js/app.min.js': ['elm/app.js']
    }
  }
};
