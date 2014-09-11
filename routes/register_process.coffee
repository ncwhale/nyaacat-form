#For OPs.
express = require 'express'
whitelist = require '../actions/minecraft/whitelist'
auth = require '../actions/auth'

router = express.Router()

router.use auth.check_session

#Router for view page.
router.get '/', (req, res)->
  res.render 'register'
  return

router.post '/', (req, res)->
  res.render 'post', req
  return

module.exports = router


