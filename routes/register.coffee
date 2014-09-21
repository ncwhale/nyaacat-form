# get: render page
# post: init a request for register
express = require 'express'
qa = require '../actions/question'
router = express.Router()

make_queue_rule = (objs)->

#Router for view page.
router.get '/', (req, res)->
  req.session.starttime ?= new Date()
  req.session.ips = req.ips
  res.render 'register',
    questions: qa.get()
  return

router.post '/', (req, res)->

  res.render 'post', req
  return

module.exports = router
