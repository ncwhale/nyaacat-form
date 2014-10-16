mongoose = require 'mongoose'
When = require 'when'

Schema = mongoose.Schema
models = mongoose.models

limitSchema = new Schema
  limit: String
  expires: Date
,
  strict: false

#Setup the TTL index on limits.
limitSchema.index
  expires: 1
,
  expireAfterSeconds: 0

#Setup limit cannot repeat
limitSchema.index
  limit: 1
,
  unique: true
  #sparse: true
  dropDups: true

limitSchema.statics.findByLimit = (limit)->
  When.promise (resolve, reject)->
    models.Limit.findOne
      limit: limit
    , (err, limit)->
      if !err and limit?
        resolve limit
      else
        reject err ? new Error "No limit yet."
      return

limitSchema.statics.findByLimits = (limits)->
  When.promise (resolve, reject)->
    models.Limit.findOne
      limit:
        $in: limits
    , (err, limit)->
      if !err and limit?
        resolve limit
      else
        reject err ? new Error "No limit yet."
      return

limitSchema.statics.testLimits = (limits)->
  When.promise (resolve, reject)->
    if !limits? or limits.length < 1
      resolve true
      return
    
    models.Limit.collection.insert limits, (err)->
      if !err 
        resolve true
      else
        reject err
      return
    return

module.exports = mongoose.model 'Limit', limitSchema
