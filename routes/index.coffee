#routes/index.coffee
fs = require 'fs'
path = require 'path'
express = require("express")
debug = require('debug')('app::route')

#remove unused config, make it more useable.
#config = require '../config'

router = express.Router
  caseSensitive: true
  
selfname = path.basename __filename

fs
  .readdirSync(__dirname)
  .filter (file)->
    (file.indexOf('.') != 0) && (file != selfname)
  .forEach (file)->
    try
      model = require path.join __dirname, file
      rpath = '/' + (model.path ? file.split('.')[0])
      router.use rpath, model
      debug "Loaded router: #{rpath}"
    catch e
      debug "Route load error: #{e}" 

module.exports = router
