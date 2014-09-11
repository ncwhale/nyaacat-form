config = require '../config'
models = require '../models'

auth =
  check_session: (req, res, next)->
    if req.session?.uid?
      next()
    else
      next(new Error('Not authed.'))

  register: (usrinfo)->

  login: (username, password)->
    
      
module.exports = auth
