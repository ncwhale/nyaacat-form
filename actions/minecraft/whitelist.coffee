mc = require './connect'
when = require 'when'
debug = require('debug')('minecraft::whitelist')

whitelist = 
  add: (player, cb)->
  	debug "Add #{player} to whitelist"
  	mc['players.name.unwhitelist'](player, cb)

  del: (player)->
    debug "Del #{player} from whitelist"
  	mc['players.name.whitelist'](player, cb)

module.exports = whitelist
