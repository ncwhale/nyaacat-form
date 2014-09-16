mongoose = require 'mongoose'
When = require 'when'

Schema = mongoose.Schema
models = mongoose.models

sessionSchema = new Schema
  session: String
  expires: Date
,
  strict: false

#Setup the TTL index on sessions.
sessionSchema.index
  expires: 1
,
  expireAfterSeconds: 0

sessionSchema.statics.findBySid = (sid)->
  When.promise (resolve, reject, notify)->
    models.Session.findOne
      _id: sid
    , (err, session)->
      if !err and session?
        resolve session
      else
        reject err ? new Error "Session not exist."
      return

module.exports = mongoose.model 'Session', sessionSchema
