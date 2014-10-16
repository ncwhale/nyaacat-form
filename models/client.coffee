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

clientSchema.index
  gameid : 1
,
  unique: true

clientSchema.statics.findByGameid = (gameid)->
  When.promise (resolve, reject)-> #, notify
    models.Client.findOne
      gameid: gameid
    , (err, client)->
      if !err
        resolve client
      else
        reject err
  
clientSchema.statics.findByMail = (mail)->
  When.promise (resolve, reject)->
    models.Client.findOne
      mail: mail
    , (err, client)->
      if !err
        resolve client
      else
        reject err

clientSchema.statics.nonExistenceTest = (id, email)->
  When.promise (resolve, reject)->
    models.Client.collection.findOne
      $or:[
        mail: email
        gameid: id
      ]
    , (err, client)->
      if !err and (!client? or client.length == 0)
        resolve true
        return
      else
        reject err or "Client Duplicate"

  

module.exports = mongoose.model 'Client', clientSchema
