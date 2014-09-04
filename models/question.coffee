config = require '../config'

#一个Question是一个问题
class Question
  constructor: (options = {}) ->
    defaults =
      name: ''      #表单内对该题目的命名，guid 或 随机 Q_xxxxxxxx
      type: 'text'  #默认Text是一个单行文本问题
      required: true #题目是否必答
      topic: '提问' #题目
      help: '这是一个问题哦喵~' #问题描述
      options: []

    @name = options.name ? "Q_#{(''+Math.random())[2..]}"
    ###
      问题 type 包含：
        text: 一行文本
        textarea: 多行文本
        radio: 单选
        multi: 多选
        check: 打勾
        email: 邮件
        url:   网址
      PS1: 其中单选多选包含 options 数组，表示可选项目
      PS2: 多选表单将变成 #{name}_#{index} 的方式表示
    ###
    @type = options.type ? defaults.type
    @help = options.help ? defaults.help
    @options = options.options ? defaults.options
    @required = options.required ? defaults.required

module.exports = Question
