config = require '../../config'
minecraft = require './minecraft'

connect = new minecraft config.minecraft

module.exports = connect