require.config
  baseUrl: 'js/lib'
  packages: [
  	{
  		name: 'when'
  		location: 'when'
  		main: 'when'
  	}
  ]
  paths: 
    model: '..'
    jquery: 'jquery-2.1.1.min'
    bootstrap: 'bootstrap.min'
    validator: 'validator.min'
    bootstrap_validator: 'bootstrapValidator/bootstrapValidator.min'
    bv_lang: 'bootstrapValidator/language'
  shim:
    bootstrap:
      deps: ['jquery']
    bootstrap_validator:
      deps: ['bootstrap']
    bv_lang:
      deps: ['bootstrap_validator']
