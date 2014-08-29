#index.coffee
fs = require 'fs'
path = require 'path'
express = require("express")
debug = require('debug')('app::route');

config = require '../config'

router = express.Router()
selfname = path.basename __filename

fs
  .readdirSync(__dirname)
  .filter (file)->
    (file.indexOf('.') != 0) && (file != selfname)
  .forEach (file)->
    try
      model = require path.join __dirname, file
      path = '/' + (model.path ? file.split('.')[0])
      router.use path, model
      debug "Loaded router: #{path}"
    catch e
      debug "Route load error: #{e}" 

module.exports = router
