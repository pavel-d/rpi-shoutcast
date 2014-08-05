shoutcast = require '../models/shoutcast'

# GET home page.
module.exports.index = (req, res) ->
  res.render 'index',
    genres: shoutcast.getGenres()

module.exports.genre = (req, res) ->
  genreName = req.params.genreName
  shoutcast.browseByGenre genreName, (err, stations) ->
    res.render 'stations',
      stations: stations
      genreName: genreName