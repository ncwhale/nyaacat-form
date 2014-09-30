# get: render page
# post: init a request for register
express = require 'express'
qa = require '../actions/question'
router = express.Router()
When = require 'when'
debug = require('debug')('route::register')
validator = require 'validator'
model = require '../models'

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

make_limit_rule = (objs)->
  #default 24 hours
  expire_date = new Date()
  expire_date.setDate expire_date.getDate()+1
  {limit: "register:#{k}:#{v}", expires: expire_date} for k,v of objs
  
###
  2. post form:
    2.1 check session
    2.2 check form (include questions)
    2.3 check limit rules
    2.4 check email/id in db
###
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
    if !(validator.isEmail(form.email) and validator.matches(form.gameid, gameid_regexp))
      reject "Bad form value"
    else
      req.body.gameid = form.gameid.split(gameid_regexp)[1]

    resolve true

  ).then((check_result)=>
    # check limit (such as same ip/email/gameid)
    model.Limit.testLimits make_limit_rule
      ip: req.ip
      id: req.body.gameid
      mail: req.body.email
  ).then((check_result)=>
    # check if the client exist.
    When.promise (resolve, reject, notify)=>
      resolve true
  ).catch((e)->
    #req.session.destroy()
    debug e
  ).done(
    ()=> #Handle Success
      res.status(200).end()
  , ()=> #Handle Error
      res.status(500).end()
  )
  return

module.exports = router
