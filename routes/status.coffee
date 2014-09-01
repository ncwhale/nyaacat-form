#status.coffee
#display default server status.
express = require 'express'
router = express.Router()
status = require '../actions/minecraft/status'

#Router for view page.
router.get '/', (req, res)->
  status.get().then( (data)->
    res.render 'status', data
  ).error((err)->
    res.render 'error', err
  )  
      
  return

module.exports = router
#module.exports.path = 'register'
