mongoose = require 'mongoose'
crypto = require 'crypto'
config = require '../config'
When = require 'when'
node_ = require 'when/node'

Schema = mongoose.Schema

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
  username: String
  password: String #with salt and hashed
  salt: Buffer
  nickname: String
  mail: String

userSchema.index
  username : 1

userSchema.statics.findByName = (username)->
  When.promise (resolve, reject, notify)->
    console.log mongoose.Use
    mongoose.models.User.findOne
      username: username
    , (err, user)->
      if !err
        resolve user
      else
        reject err

userSchema.methods.updateSalt = (info...)->
  salt = generate_salt.apply null, info
  @set 'salt', salt

userSchema.methods.updatePassword = (newPassword)->
  if @isSelected 'salt'
    password = salt_password newPassword, @get('salt')
    @set 'password', password

userSchema.methods.randomPassword = ()->
  random_password = crypto.randomBytes(12).toString('base64')

userSchema.methods.checkPassword = (password)->
  if @isSelected('salt') and @isSelected('password')
    return (salt_password password, @get('salt')) == @get('password')
  no

module.exports = mongoose.model 'User', userSchema
