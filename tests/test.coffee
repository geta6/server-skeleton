# Environment

process.env.NODE_ENV = 'test'

# Dependencies

path = require 'path'
assert = require 'assert'
request = require 'supertest'
express = require path.resolve 'config', 'app.coffee'

describe 'node-server-skeleton', ->

  it 'sohuld be 200 index', (done) ->
    request(express)
      .get('/')
      .expect(200)
      .end done

