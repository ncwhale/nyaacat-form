config = 
  express:
    settings:
      "trust proxy": "loopback"
      "view engine": "jade"
      port:     3000
    logger:   'tiny'
    views:    'views'
    session:
      name:   'nyan'
      keys:    ['Yakumo Yukari', 'Saigyouji Yuyuko', 'Yagokoro Eirin', 'Yasaka Kanako', 'Hijiri Byakuren']
      secret: 'BBA Yukari'
      secureProxy: false
    develop:  true
    urlencoded:
      extended: true

  #mailer 配置电子邮件系统
  mailer:
    template:
      path: 'mails'
      engine: 'jade'
    bot: #除了template共享配置外，剩下的每个节都单独配置一个邮送账号
      type: 'smtp'
      host: 'smtp.somewhere.com'
      port: 495
      ssl:  true
      user: 'someone@somewhere.com'
      pass: 'passwordNeeded!'
      sender: 'Who <someone@somewhere.com>'

  #配置数据库
  mongodb: 'mongodb://localhost/collection'

  #配置到Minecraft JSONAPI 的连接
  minecraft:
    host: 'Your server address/domain'
    port: 20059
    user: 'Your username'
    pass: 'Your password here.'

module.exports = config
