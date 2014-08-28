require.config({
  baseUrl: 'js/lib',
  paths: {
    model: '..',
    jquery: 'jquery-2.1.1.min',
    bootstrap: 'bootstrap.min'
  },
  shim: {
    bootstrap: {
      deps: ['jquery']
    }
  }
});

//# sourceMappingURL=require-config.map
