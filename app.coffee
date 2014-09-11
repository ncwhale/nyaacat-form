express = require("express")
path = require("path")
favicon =  require('serve-favicon')
logger = require("morgan")
session = require 'express-session'
session_store = require('connect-mongo')(session)
bodyParser = require("body-parser")
stylus = require('stylus')
debug = require('debug')('app');

config = require './config'
models = require './models'
routes = require './routes'

app = express()

# view engine setup
app.set "views", path.join(__dirname, config.express.views ? "views")
app.set "view engine", "jade"

# env setup
app.set 'port', config.express.port ? 3000
app.set 'env', 'production'
app.set 'env', 'development' if config.express.develop?

# static res
app.use favicon(path.join(__dirname, 'public/ico/favicon.ico'))
app.use stylus.middleware(path.join(__dirname , 'public'))
app.use express.static(path.join(__dirname, "public"))

# dymaic setup
app.use logger(config.express.logger ? 'dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded config.express.urlencoded
app.use session
  secret: config.express.session.secret
  resave: false
  saveUninitialized: false
  store: new session_store
    url: config.mongodb

app.use routes

#/ catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error("Not Found")
  err.status = 404
  next err
  return


#/ error handlers

# development error handler
# will print stacktrace
if app.get("env") is "development"
  app.use (err, req, res, next) ->
    err.status ?= 500
    res.status err.status    
    res.render "error",
      message: err.message
      error: err
    debug "Error: #{err.message}"
    return

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render "error",
    message: err.message
    error:
      status: err.status or 500

  return

module.exports = app
