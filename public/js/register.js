requirejs(['jquery', 'bootstrap', 'bootstrap_validator'], function($, bs, bv) {
  return $(function() {
    return $('#register-form').bootstrapValidator({
      live: 'enabled',
      submitButtons: 'button[type="submit"]',
      trigger: null,
      feedbackIcons: {
        valid: 'fa fa-check-circle',
        invalid: 'fa fa-times-circle',
        validating: 'fa fa-star fa-spin'
      }
    });
  });
});

//# sourceMappingURL=register.map
