class M3u
  constructor: (contents) ->
    @contents = contents
  getStreams: ->
    @contents.split('\n').filter (line) ->
      line && !~line.indexOf('#')

module.exports = M3u
