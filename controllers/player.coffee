Player = require '../models/player'
shoutcast = require '../models/shoutcast'
player = new Player()

module.exports.station = (req, res) ->
  streamID = req.params.stationID
  shoutcast.getStream streamID, (err, stream) ->
    player.open stream
    res.send 204

module.exports.stations = (req, res) ->
  genreName = req.params.genreName
  shoutcast.browseByGenre genreName, (err, stations) ->
    res.json(stations)

module.exports.pause = (req, res) ->
  player.pause()
  res.send 204

module.exports.currentTrack = (req, res) ->
  shoutcast.getCurrentTrack  (err, currentTrack) ->
    res.json(currentTrack)