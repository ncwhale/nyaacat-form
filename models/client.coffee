mongoose = require 'mongoose'
When = require 'when'

Schema = mongoose.Schema
models = mongoose.models

clientSchema = new Schema
  mail: String
  gameid: String
  mailverify: Boolean
  logs: [ String ]
  ips: [ String ]
,
  strict: false

clientSchema.index
  mail : 1
,
  unique: true
  sparse: true

clientSchema.index
  gameid : 1
,
  unique: true
  sparse: true

clientSchema.statics.findByGameid = (gameid)->
  When.promise (resolve, reject, notify)->
    models.Client.findOne
      gameid: gameid
    , (err, client)->
      if !err
        resolve client
      else
        reject err
  
clientSchema.statics.findByMail = (mail)->
  When.promise (resolve, reject, notify)->
    models.Client.findOne
      mail: mail
    , (err, client)->
      if !err
        resolve client
      else
        reject err

module.exports = mongoose.model 'Client', clientSchema
