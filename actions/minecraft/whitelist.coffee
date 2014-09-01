mc = require './connect'
nodefn = require 'when/node'
debug = require('debug')('minecraft::whitelist')

class whitelist
  add: (player)->
    debug "Add #{player} to whitelist"
    nodefn.call(mc['players.name.unwhitelist'], [ player ])

  del: (player)->
    debug "Del #{player} from whitelist"
  	nodefn.call(mc['players.name.whitelist'], [ player ])

module.exports = whitelist
