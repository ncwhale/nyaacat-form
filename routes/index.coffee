#index.coffee
fs = require 'fs'
path = require 'path'
express = require("express")
debug = require('debug')('app::route');

config = require '../config'

router = express.Router()
selfname = path.basename __filename
#routes = []

fs
  .readdirSync(__dirname)
  .filter (file)->
    (file.indexOf('.') != 0) && (file != selfname)
  .forEach (file)->
    try
      model = require path.join __dirname, file
      #routes[model.name] = model
      router.use "/#{model.path ? file}", model
      debug "Loaded router: /#{model.path ? file}"
    catch e
      debug "Route load error: #{e}" 

# GET home page. 
#router.get "/", (req, res) ->
#  res.render "index",
#    title: "Express"
#  return

module.exports = router
