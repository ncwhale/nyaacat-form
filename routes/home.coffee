express = require 'express'
router = express.Router()

#Router for home page.
router.get '/', (req, res)->
  res.render 'index',
    title: "Nyaa"
  return

module.exports = router
module.exports.path = ''
