{expect} = require('chai')
shoutcast = require('../../models/shoutcast')


describe 'Shoutcast', ->
  describe '.browseByGenre(genre, callback)', ->
    it 'should return available genres', ->
      shoutcast.browseByGenre 'Jazz', (err, genres) ->
        expect(err).to.be.null
        expect(genres).to.be.an 'array'

  describe '.getGenres()', ->
    it 'should return genres array', (done) ->
      genres = shoutcast.getGenres()
      expect(genres).to.be.an 'array'
      done()

  describe '.getStreams(genre)', ->
    it 'should return array of stream urls', (done) ->
      stationID = '171444'
      shoutcast.getStreams stationID, (err, streams) ->
        expect(streams).to.an 'array'
        done()