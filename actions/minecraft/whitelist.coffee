mc = require './connect'
nodefn = require 'when/node'
debug = require('debug')('minecraft::whitelist')

class whitelist
  add: (player)->
    debug "Add #{player} to whitelist"

    args = [
      player
      ]

    nodefn.call (arg, cb)->
      mc['players.name.whitelist'] arg, cb
    , args

  del: (player)->
    debug "Del #{player} from whitelist"

    args = [
      player
      ]
      
    nodefn.call (arg, cb)->
      mc['players.name.unwhitelist'] arg, cb
    , args

module.exports = new whitelist
