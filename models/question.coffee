mongoose = require 'mongoose'
crypto = require 'crypto'
config = require '../config'
When = require 'when'

Schema = mongoose.Schema
models = mongoose.models

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
questionTypes = 'text textarea radio multi check email url'.split ' '

questionSchema = new Schema
  name: String            #表单内对该题目的命名，guid 或 随机 Q_xxxxxxxx
  type:                   #默认Text是一个单行文本问题
    type: String
    enum: questionTypes
  required: Boolean       #题目是否必答
  topic: String           #题目
  help: String            #问题描述
  choices: [ String ]     #问题选项

questionSchema.index
  name: 1
,
  unique: true
  sparse: true

questionSchema.statics.findTopicByNames = (names)->
  When.promise (resolve, reject, notify)->
    models.Question.find
      name:
        $in: names
    , (err, questions)->
      if !err
        resolve questions
      else
        reject err

module.exports = mongoose.model 'Question', questionSchema
