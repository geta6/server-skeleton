exports.Content = (app) ->

  {User} = app.get 'models'
  {crypto} = app.get 'helper'

  index: (req, res) ->
    res.statusCode = 200
    res.end()
