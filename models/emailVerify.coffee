mongoose = require 'mongoose'
When = require 'when'

Schema = mongoose.Schema
models = mongoose.models

# Use id for verify code.
emailVerifySchema = new Schema
  email:  String
  action: String
  data: {}
  expires: Date
,
  strict: false

# Setup the TTL index on EmailVerify.
emailVerifySchema.index
  expires: 1
,
  expireAfterSeconds: 0

# One email address may need more actions one time.
# So no limit here.
emailVerifySchema.statics.findById = (id)->
  When.promise (resolve, reject)->
    models.EmailVerify.collection.findById id,
      (err, EmailVerify)->
        if !err and EmailVerify?
          resolve EmailVerify
        else
          reject err
        return
    return

emailVerifySchema.statics.findByEmail = (email)->
  When.promise (resolve, reject)->
    models.EmailVerify.find
      email: email
    , (err, EmailVerify)->
      if !err
        resolve EmailVerify
      else
        reject err
      return

    models.EmailVerify.collection.insert EmailVerifys, (err)->
      if !err
        resolve true
      else
        reject err
      return
    return

module.exports = mongoose.model 'EmailVerify', emailVerifySchema
