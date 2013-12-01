crypto = require 'crypto'

c = exports.crypto = (src, algorithm = 'md5') ->
  md5 = crypto.createHash algorithm
  md5.update src, 'utf8'
  return md5.digest 'hex'

c.md5 = (src) ->
  return c src, 'md5'

c.sha1 = (src) ->
  return c src, 'sha1'

c.sha256 = (src) ->
  return c src, 'sha256'

c.sha512 = (src) ->
  return c src, 'sha512'

