# Dependency

fs = require 'fs'
path = require 'path'
util = require 'util'
express = require 'express'
mongoose = require 'mongoose'
#passport = require 'passport'
direquire = require 'direquire'

# Database

mongoose.connect process.env.MONGODB

# Application

module.exports = app = express()
app.disable 'x-powerd-by'
app.set 'events', direquire 'events'
app.set 'models', direquire 'models'
app.set 'helper', direquire 'helper'
app.set 'session', new ((require 'connect-redis') express)
  prefix: process.env.SESS_PREFIX
app.use express.favicon()
if process.env.NODE_ENV isnt 'test'
  app.use express.logger 'dev'
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.session
  store: app.get 'session'
  secret: process.env.SESS_TOKEN
  cookie: maxAge: 365 * 24 * 60 * 60 * 1000
#app.use passport.initialize()
#app.use passport.session()
app.use app.router
if process.env.NODE_ENV isnt 'production'
  app.use express.errorHandler()

# Authenticate

# {User} = app.get 'models'
# passport.serializeUser (user, done) ->
#   done null, user
# passport.deserializeUser (user, done) ->
#   User.findOne _id: user._id, done
# passport.use ...

# Routes

Content = (app.get 'events').Content app

app.get '/',  Content.index
