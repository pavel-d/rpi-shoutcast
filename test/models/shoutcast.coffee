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

  describe '.getStream(genre)', ->
    it 'should return a stream urls', (done) ->
      stationID = '171444'
      shoutcast.getStream stationID, (err, streams) ->
        expect(streams).to.a 'string'
        done()