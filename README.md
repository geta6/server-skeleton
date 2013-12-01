# server-skeleton

  node.js API server skeleton. (without view)


# requiement

  * mongodb
  * redis


# usage

  install:

    $ git clone https://github.com/geta6/server-skeleton
    $ cd server-skeleton
    $ npm i

  config:

    $ vi Makefile

  start:

    $ make


# scaffold

    $ ./bin/scaffold
    Usage: scaffold -f -t [type] [name]

      -f, --force : overwrite if file exists
      -t, --type  : event or model or helper
      [name]      : file name, make event and model upper captial


# directories

  * `config`
  * `events`
  * `models`
  * `helper`


## config

  app config.

file       | role
-----------|--------------------
app.coffee | exports express app
web.coffee | starting web server


## events

  create :

    $ ./bin/scaffold -t event account
    -> ./events/Account.coffee

  edit :

    $ vi ./events/Account.coffee

    exports.Account = (app) ->

      {User} = app.get 'models'

      user: (req, res) ->
        User.findById req.params.id, (err, user) ->
          return res.json 404, {e: 'X-<'} unless user
          res.json 200, user

  load :

    $ vi ./config/app.coffee

    :
    Account = (app.get 'events').Account app
    app.get '/account/:id.json',  Account.user
    :


## models

  create :

    $ ./bin/scaffold -t model item
    -> ./models/Item.coffee

  edit :

    $ vi ./models/Item.coffee

    ItemModel = new mongoose.Schema
      name: type: String
      count: type: Number
      owner: type: mongoose.Schema.Types.ObjectId, ref: 'users'
    ,
      versionKey: off
    :

  load :

    $ vi ./events/Account.coffee

    exports.Account = (app) ->

      {User, Item} = app.get 'models'

      user: (req, res) ->
        User.findById req.params.id, (err, user) ->
          return res.json 404, {e: 'X-<'} unless user
          Item.find owner: user._id, (err, items) ->
            res.json 200, { user: user, items: items }


## helper

  create :

    $ ./bin/scaffold -t helper errors
    -> ./helper/errors.coffee

  edit :

    $ vi ./helper/errors.coffee

    http = require 'http'
    exports.errors = (err, code, res) ->
      res.jsonp code,
        error: http.STATUS_CODES[code]
        message: err

  load :

    $ vi ./events/Account.coffee

    exports.Account = (app) ->

      {User, Item} = app.get 'models'
      {errors} = app.get 'helper'

      user: (req, res) ->
        User.findById req.params.id, (err, user) ->
          return errors err, 404, res unless user
          Item.find owner: user._id, (err, items) ->
            res.json 200, { user: user, items: items }


# tasks

## run as development mode

    $ make


## run as production mode

    $ make production


## test

  edit:

    $ vi ./tests/test.coffee

  run:

    $ make test


# MIT LICENSE

Copyright &copy; 2013 geta6 licensed under [MIT](http://opensource.org/licenses/MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
