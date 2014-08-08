express = require 'express'
router = express.Router()
controllers = require '../controllers'

router.get '/', controllers.main.index
router.get '/:genreName', controllers.main.genre

router.get '/player/station/current/track', controllers.player.currentTrack
router.post '/player/station/:stationID', controllers.player.station
router.post '/player/pause', controllers.player.pause
router.post '/player/pause', controllers.player.pause

router.get '/genre/:genreName/stations', controllers.player.stations

module.exports = router