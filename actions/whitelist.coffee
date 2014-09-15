#Work flow:
# 1.Answer questions.
# 2.Verify email address.
# 3.Let OP do the vote/accept/deny.
# 4.Send success/fail mail.
#

whitelist =
  generate_questions: ()->

  verify_email: (req, whitelist, next)->
    req.session.verify_whitelist = whitelist.id
    

module.exports = whitelist
