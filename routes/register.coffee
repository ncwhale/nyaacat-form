# get: render page
# post: init a request for register
express = require 'express'
qa = require '../actions/question'
router = express.Router()

make_queue_rule = (objs)->

###
Process flow:
  1. view page: set session.
  2. post form:
    2.1 check session
    2.2 check form
    2.3 check rules
    2.4 check 
  3. check email
  4. goto process by ops.
###

#Router for view page.
router.get '/', (req, res)->
  req.session.starttime ?= new Date()
  req.session.ip = req.ip
  req.session.ips = req.ips
  res.render 'register',
    questions: qa.get()
  return

router.post '/', (req, res)->

  res.render 'post', req
  return

module.exports = router
