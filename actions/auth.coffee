config = require '../config'
models = require '../models'

auth =
  check_session: (req, res, next)->
    if req.session?.uid?
      models.User.find
        _id: req.session.uid
      .then (user)->
        req.user = user
        next()
      .catch (err)->
        next err
    else
      next(new Error('Not authed.'))

  register: (userinfo)->
    When.promise (resolve, reject, notify)->
      #Check the user fields must there.
      user = new models.User userinfo
      reject new Error 'No Email' if !user.mail?
      
      userinfo.password = models.User.randomPassword if !userinfo.password?

      #create a random salt for this user.
      user.updateSalt "#{new Date()}", user.mail
      #then update password if needed.
      user.updatePassword password

      user.save (err)->
        if !err
          resolve userinfo
        else
          reject err
        return

  login: (username, password)->
    models.User.findByMail(username).then (user)->
      if user.checkPassword password
        return user
      else
        throw new Error 'Spam User.'
        
    
      
module.exports = auth
