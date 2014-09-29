# get: render page
# post: init a request for register
express = require 'express'
qa = require '../actions/question'
router = express.Router()
When = require 'when'
debug = require('debug')('route::register')
validator = require 'validator'

###
Process flow:
  1. view page: set session.
  2. post form:
    2.1 check session
    2.2 check form (include questions)
    2.3 check limit rules
    2.4 check email/id in db
  3. check email > give to another process.
  4. goto process by ops.
###

clip_question = (q)->
  sq = []
  for v in q
    sq.push
      name: v.name
      type: v.type
      topic: v.topic
  sq

#Router for view page.
router.get '/', (req, res)->
  #req.session.starttime ?= new Date()
  req.session.ip = req.ip
  questions = qa.get()
  req.session.questions = clip_question questions
  res.render 'register',
    questions: questions
  return

gameid_regexp = /^([a-zA-Z0-9]+)喵?～?$/

make_queue_rule = (objs)->

router.post '/', (req, res)->
  When.promise((resolve, reject, notify)=>
    # check session item exist.
    if !req.session.ip? or !req.session.questions? or req.session.ip != req.ip
      reject "Bad session"

    # check form
    form = req.body
    if !(req.body? and form.gameid? and form.email? and form.referal? and form.accountType? and form.selfIntro?)
      reject "Bad form submit"

    # and questions
    for v in req.session.questions
      reject "Question not full filled" unless req.body[v.name]?

    # and validator them
    if !(validator.isEmail(form.email) and validator. )

  ).then((check_result)=>

  ).catch((e)->
    debug e
  ).done(
      ()=> #Handle Success
      res.status(200).end()
    , ()=> #Handle Error
      res.status(500).end()
  )
  return

module.exports = router
