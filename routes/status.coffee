#status.coffee
#display default server status.
express = require 'express'
router = express.Router()
status = require '../actions/server_status'

#Router for view page.
router.get '/', (req, res)->
  res.render 'status',
    title: "Nyaa"
  return

module.exports = router
module.exports.path = 'register'
