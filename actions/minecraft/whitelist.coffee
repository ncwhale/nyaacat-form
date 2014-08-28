mc = require './connect'
when = require 'when'

whitelist_operation = 
  add: (player, cb)->
  	debug "Add #{player} to whitelist"
  	mc['players.name.unwhitelist'](player, cb)

  del: (player)->
  	mc['players.name.whitelist'](player, cb)