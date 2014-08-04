express = require 'express'
router = express.Router()
shoutcast = require '../models/shoutcast'

# GET home page.
router.get '/', (req, res) ->
  res.render 'index',
    genres: shoutcast.getGenres()

router.get '/:genreName', (req, res) ->
  genreName = req.params.genreName
  shoutcast.browseByGenre genreName, (err, stations) ->
    res.render 'stations',
      stations: stations
      genreName: genreName

module.exports = router