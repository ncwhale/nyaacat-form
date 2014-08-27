config = 
  express:
    logger:   'tiny'
    port:     3000
    session:
      name:   'nyan'
      keys:    ['Yakumo Yukari', 'Saigyouji Yuyuko', 'Yagokoro Eirin', 'Yasaka Kanako', 'Hijiri Byakuren']
      secret: 'BBA Yukari'
      secureProxy: false
    develop:  true
    urlencoded:
      extended: true
  mongodb:
    link:     ''
  minecraft:
    host: 'localhost'
    port: 25565
    user: 'admin'
    pass: 'password from jsonapi config'

module.exports = config