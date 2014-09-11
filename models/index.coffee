#models/index.coffee
fs = require 'fs'
path = require 'path'
mongoose = require 'mongoose'
debug = require('debug')('app::model')
 
models = {}
selfname = path.basename __filename

fs
  .readdirSync(__dirname)
  .filter (file)->
    (file.indexOf('.') != 0) && (file != selfname)
  .forEach (file)->
    try
      model = require path.join __dirname, file
      rpath = (model.modelName ? file.split('.')[0])
      models[rpath] = model
      debug "Loaded model: #{rpath}"
    catch e
      debug "Model load error: #{e}" 

module.exports = models
