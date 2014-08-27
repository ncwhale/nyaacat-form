config = require '../config'
minecraft = require './minecraft'

minecraft_connect = new minecraft config.minecraft

module.exports = minecraft_connect