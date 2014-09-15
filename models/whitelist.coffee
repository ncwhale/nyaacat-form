mongoose = require 'mongoose'
crypto = require 'crypto'
config = require '../config'
When = require 'when'

Schema = mongoose.Schema
models = mongoose.models

whitelistSchema = new Schema
  mail: String
  gameid: String
  mailverify: Bool
  logs: [{String}]
,
  strict: false

whitelistSchema.index
  mail : 1
,
  unique: true
  sparse: true

whitelistSchema.index
  gameid : 1
,
  unique: true
  sparse: true

whitelistSchema.statics.findByGameid = (gameid)->
  When.promise (resolve, reject, notify)->
    models.User.findOne
      gameid: gameid
    , (err, user)->
      if !err
        resolve user
      else
        reject err
  
whitelistSchema.statics.findByMail = (mail)->
  When.promise (resolve, reject, notify)->
    models.User.findOne
      mail: mail
    , (err, user)->
      if !err
        resolve user
      else
        reject err

module.exports = mongoose.model 'Whitelist', userSchema
