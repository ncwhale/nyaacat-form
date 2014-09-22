require.config({
  baseUrl: 'js/lib',
  packages: [
    {
      name: 'when',
      location: 'when',
      main: 'when'
    }
  ],
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
