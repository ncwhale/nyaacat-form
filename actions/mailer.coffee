nodemailer = require 'nodemailer'
smtpTransport = require 'nodemailer-smtp-transport'
directTransport = require 'nodemailer-direct-transport'
htmlToText = require('nodemailer-html-to-text').htmlToText
jade = require 'jade'
debug = require('debug')('app::mailer')
When = require 'when'

config = require '../config'

class Mailer
  constructor: (@options) ->
    defaults =
      template:
        path: 'mails'
        engine: 'jade'

    for i of defaults
      @options[i] = defaults[i]  unless @options[i]

    for i,v of @options
      continue unless v.type?
      @[i] = {}

      switch v.type
        when 'smtp', 'service'
          @[i]['transport'] = nodemailer.createTransport smtpTransport v
        when 'direct', 'sendmail'
          @[i]['transport'] = nodemailer.createTransport()

      if v.htmlToText
         @[i]['transport'].use 'compile', htmlToText()
         
      @[i]['options'] =
        from: v.sender

      @[i]['sendmail'] = (options)=>
        options.sender = i
        @sendmail options
        

  sendmail: (options) ->
    When.promise (resolve, reject, notify)=>
      reject new Error 'Sender not configured.' unless @[options.sender]?

      if options.template?
        notify 'compile html'
        try
          options.html = jade.renderFile path.join(@options.template.path, "#{options.template}.#{@options.template.engine}") , options.data ? options
        catch e
          reject e

      for k,v of @[options.sender]['options']
        options[k] = v unless options[k]?

      notify 'sending.'
      @[options.sender]['transport'].sendMail options, (err, info)->
        if !err
          resolve info
        else
          reject err

module.exports = new Mailer config.mailer
