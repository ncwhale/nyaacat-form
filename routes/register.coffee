#
express = require 'express'
router = express.Router()

#Router for view page.
router.get '/', (req, res)->
  res.render 'register'
  return

router.post '/', (req, res)->
  res.render 'post', req
  return

module.exports = router
#module.exports.path = 'register'
