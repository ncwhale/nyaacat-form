mc = require './connect'
nodefn = require 'when/node'


status = 
  get: ()->
    nodefn.call (cb)->
      mc['server'] [], cb


module.exports = status
