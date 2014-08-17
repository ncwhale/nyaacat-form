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

module.exports = config