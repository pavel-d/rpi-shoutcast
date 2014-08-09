{spawn, exec} = require('child_process')
events = require('events')
util = require('util')


class Player extends events.EventEmitter
  constructor: ->
    # @process = spawn('mplayer', ['-input', 'file=mp_pipe', '-idle'])
    # @process.on 'exit', (code, sig) =>
      # @emit 'complete'

  exit: ->
    # if @process
      # @process.kill('SIGTERM')
    # @emit 'stop'

  open: (streamURL) ->
    exec "echo 'loadfile #{streamURL}' > mp_pipe"
    @playing = true

  pause: ->
    exec 'echo pause > mp_pipe'
    @playing = !@playing

  playing: false

  isPlaying: ->
    @playing



module.exports = Player