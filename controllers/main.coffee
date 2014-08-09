shoutcast = require '../models/shoutcast'

# GET home page.
module.exports.index = (req, res) ->
  res.render 'index'