requirejs(['jquery', 'bootstrap', 'bootstrap_validator'], function($, bs, bv) {
  return $(function() {
    return $('#register-form').bootstrapValidator({
      live: 'enabled',
      submitButtons: 'button[type="submit"]',
      trigger: null,
      feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
      }
    });
  });
});

//# sourceMappingURL=register.map
