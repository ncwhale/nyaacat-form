config = 
  express:
    logger:   'tiny'
    port:     3000
    views:    'views'
    session:
      name:   'nyan'
      keys:    ['Yakumo Yukari', 'Saigyouji Yuyuko', 'Yagokoro Eirin', 'Yasaka Kanako', 'Hijiri Byakuren']
      secret: 'BBA Yukari'
      secureProxy: false
    develop:  true
    urlencoded:
      extended: true
  mailer:
    template:
      path: 'mails'
      engine: 'jade'
    bot:
      type: 'smtp'
      host: 'smtp.somewhere.com'
      port: 495
      ssl:  true
      user: 'someone@somewhere.com'
      pass: 'passwordNeeded!'
      sender: 'Who <someone@somewhere.com>'
      
  mongodb: 'mongodb://localhost/collection'

module.exports = config
