requirejs ['jquery', 'bootstrap','bootstrap_validator', 'bv_lang/zh_CN'], ($)->
  $ ()->
    $('#register-form').bootstrapValidator
      live: 'enabled'
      submitButtons: 'button[type="submit"]'
      trigger: null
      feedbackIcons:
        valid: 'fa fa-2x fa-check-circle'
        invalid: 'fa fa-2x fa-times-circle'
        validating: 'fa fa-2x fa-star fa-spin'
  
