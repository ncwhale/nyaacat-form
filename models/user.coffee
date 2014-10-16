mongoose = require 'mongoose'
crypto = require 'crypto'
config = require '../config'
When = require 'when'

Schema = mongoose.Schema
models = mongoose.models

#salt function
generate_salt = (info...)->
  hash = crypto.createHash 'sha256'
  hash.update crypto.randomBytes 128
  hash.update "#{i}" for i in info
  Buffer.concat [crypto.randomBytes(32), hash.digest()]

salt_password = (password, salt) ->
  hash = crypto.createHash 'sha256'
  hash.update salt
  hash.update "#{password}"
  hash.digest('hex')

userSchema = new Schema
  mail: String
  nickname: String
  password: String #with salt and hashed
  salt: Buffer

userSchema.index
  mail : 1
, 
  unique: true

userSchema.statics.findByMail = (mail)->
  When.promise (resolve, reject)->
    models.User.findOne
      mail: mail
    , (err, user)->
      if !err
        resolve user
      else
        reject err

userSchema.statics.randomPassword = ()->
  crypto.randomBytes(12).toString('base64')

userSchema.methods.updateSalt = (info...)->
  @set 'salt', generate_salt.apply null, info

userSchema.methods.updatePassword = (newPassword)->
  if @isSelected 'salt'
    @set 'password', salt_password newPassword, @get('salt')

userSchema.methods.checkPassword = (password)->
  if @isSelected('salt') and @isSelected('password')
    return (salt_password password, @get('salt')) == @get('password')
  no

module.exports = mongoose.model 'User', userSchema
