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
      password = userinfo.password
      reject new Error 'No username' if !user.username?
      reject new Error 'No Email' if !user.mail?

      #Check if the same username was used already
      models.User.findByName user.username
      .done (old_user)->
        reject new Error 'Already Exists.' if old_user?

        #create a random salt for this user.
        user.updateSalt "#{new Date()}"
        #then update password if needed.
        password = user.randomPassword if !user.password?
        user.updatePassword password
        user.save 
        
      , (err)->
        reject err

  login: (username, password)->
    models.User.findByName(username).then (user)->
      if user.checkPassword password
        return user
      else
        throw new Error 'Spam User.'
        
    
      
module.exports = auth
