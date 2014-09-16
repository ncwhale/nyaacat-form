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

limitSchema.statics.findByLimit = (limit)->
  When.promise (resolve, reject, notify)->
    models.Limit.findOne
      limit: limit
    , (err, limit)->
      if !err and limit?
        resolve limit
      else
        reject err ? new Error "No limit yet."
      return

limitSchema.statics.findByLimits = (limits)->
  When.promise (resolve, reject, notify)->
    models.Limit.findOne
      limit:
        $in: limits
    , (err, limit)->
      if !err and limit?
        resolve limit
      else
        reject err ? new Error "No limit yet."
      return


module.exports = mongoose.model 'Limit', limitSchema
