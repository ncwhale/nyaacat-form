config = require '../config'

#一个Question是一个问题
class Question
  constructor: (options = {}) ->
    defaults =
      name: ''  #系统内对该题目的标记，英文数字或guid
      type: 'Text' #默认Text是一个单行文本问题
      topic: '' #题目
      description: '' #问题描述

    @name = options.name ? 
    @type = options.type ? defaults.type
    @topic = options.topic ? defaults.topic

  get: ->
    return
            

module.exports = new Question
