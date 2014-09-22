#问题应该是直接由数据库查询出来的，不过目前暂时直接返回JSON

question = 
  get: ()->
    [
      {
        name: 'wikiurl' 
        type: 'url'
        required: true
        topic: '「喵窝」服务器的 Wiki 地址是？'
        help: ''
        choices: [
        ]
      }
      {
        name: 'mapurl'
        type: 'url'
        required: true
        topic: '「喵窝」服务器的动态地图地址是？'
        help: ''
        choices: [
        ]
      }
      {
        name: 'epiccmd'
        type: 'text'
        required: true
        topic: '「喵窝」服务器中去往矿界的命令是？'
        help: ''
        choices: [
        ]
      }
      {
        type: 'radio', required: true, name: 'q1', topic: '首次登录时因为网络问题掉进虚空，应该怎么办？', choices:[
              '我要保装备，快速按下收费的 /home 或 /spawn 返回出生点',
              '什么都不做，重生后使用出生点附近的重置木牌来再次获取新人装备',
              '在服内用力发牢骚'
            ]
      }
      {
        type: 'radio', required: true, name: 'q2', topic: '我(或和其他玩家一起)想要使用大片土地建立村落，应该...?', choices:[
              '在社群向管理组申请建立村落，并按要求附上村落NW-SE范围坐标、村落名称、负责玩家和建设计划',
              '用力刷围栏等方块，圈出大片土地，这块地方就是我的了',
              '直接找个地方开造'
            ]
      }
      {
        type: 'radio', required: true, name: 'q3', topic: '看到了很有意思的建筑，但是找不到入口或门打不开，应该...?', choices:[
              '尝试联系负责玩家请求进入',
              '看起来附近没人，我挖进去'
            ]
      }
      {
        type: 'radio', required: true, name: 'q4', topic: '走到半路看到了铁路，但是太高上不去，要怎么办？', choices:[
              '沿着铁路走，在就进的车站或其他预留的入口或隧道上方进入',
              '挖一堆泥土石头，用方块堆叠的方式跳进去'
            ]
      }
      {
        type: 'radio', required: true, name: 'q5', topic: '在矿界挖矿时，应该？', choices:[
              '随便找个地方或别人挖过的矿道，见到想要的矿石就挖走，反正有 /home 不抖',
              '斜下方或旋转式向下挖掘，在必要位置建立落脚点存放物品箱子和熔炉等，以便下次再来挖掘'
            ]
      }
      {
        type: 'textarea', required: true, name: 'q6', topic: '进入了别人的村落 看到没有锁的箱子 我应该？'
      }
      {
        type: 'textarea', required: true, name: 'q7', topic: '那个人的建筑物上有漂亮的钻石块，我还缺很多钻石工具，我应该？'
      }
      {
        type: 'textarea', required: true, name: 'q8', topic: '遇到了自然村庄，我会？'
      }
      {
        type: 'textarea', required: true, name: 'q9', topic: '如果没有通过审核，您的想法或行动'
      }
    ]


module.exports = question