#
express = require 'express'
router = express.Router()

#Router for view page.
router.get '/', (req, res)->
  res.render 'register',
    title: 'Minecraft 服务器「喵窝」白名单申请'
  return

router.post '/', (req, res)->
  res.render 'post', req
  return

module.exports = router
#module.exports.path = 'register'
