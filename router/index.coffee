express = require 'express'
router = express.Router()
controllers = require '../controllers'

router.get '/', controllers.main.index

router.get '/player/nowPlaying', controllers.player.nowPlaying
router.post '/player/station/:stationID', controllers.player.station
router.post '/player/pause', controllers.player.pause
router.post '/player/pause', controllers.player.pause

router.get '/genres/', controllers.player.genres
router.get '/genres/:genreName/stations', controllers.player.stations

module.exports = router