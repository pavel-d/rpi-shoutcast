rpi-shoutcast
=============

Web interface for mplayer with Shoutcast client

Installing
----------
```
git clone https://github.com/pavel-d/rpi-shoutcast.git
cd rpi-shoutcast
npm install && mkfifo mp_pipe
```

Running
-------
```
mplayer -input file=mp_pipe -idle &
NODE_ENV=production bin/www
```

Open `http://localhost:3000/` in browser
