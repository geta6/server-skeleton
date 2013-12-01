# Dependency

path = require 'path'
http = require 'http'

# Application

app = require path.resolve 'config', 'app'

# HTTP Server

port = process.env.PORT || 3000
env  = process.env.NODE_ENV

http.createServer(app).listen port, ->
  console.log "Express server listening on port #{port} with mode #{env}"

