{expect} = require('chai')
{exec} = require('child_process')
Player = require('../../models/player')

describe 'Player', ->
  describe 'constructor', ->
    it 'should spawn mplayer process', (done) ->
      player = new Player
      pid = player.process.pid

      exec "ps #{pid}", (err, out) ->
        expect(out).to.include('mplayer')
        player.exit()
        done()