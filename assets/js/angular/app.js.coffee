window.app = angular.module('player', ['ngRoute'])

app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: 'partials/index.html',
      controller: 'IndexController'
    .when '/stations/:genreName',
      templateUrl: 'partials/stations.html',
      controller: 'StationsController'
]

app.controller 'IndexController', ['$scope', 'Player', ($scope, Player) ->
  $scope.loadingGenres = true

  Player.getGenres (genres) ->
    $scope.genres = genres
    $scope.loadingGenres = false
]


app.controller 'StationsController', ['$scope', '$routeParams', 'Player', ($scope, $routeParams, Player) ->
  $scope.loadingStations = true
  genreName = $routeParams.genreName
  $scope.genreName = genreName

  Player.getStations genreName, (stations)->
    $scope.stations = stations
    $scope.loadingStations = false

  $scope.playStation = (station) ->
    Player.playStation station
]


app.controller 'PlayerController', ['$scope', 'Player', '$timeout', ($scope, Player, $timeout) ->
  $scope.$on 'nowPlayingChanged', ->
    $scope.nowPlaying = Player.nowPlaying

  $scope.pause = ->
    Player.pause()

  updateNowPlaying = ->
    Player.updateNowPlaying (data) ->
      $timeout(updateNowPlaying, 2000);

  updateNowPlaying()
]


app.service 'Player', ['$rootScope', '$http', ($rootScope, $http) ->
  nowPlaying: { station: {}, isPlaying: false }

  getStations: (genreName, callback) ->
    $http
      .get "/genres/#{genreName}/stations"
      .success (data) ->
        callback(data)

  playStation: (station) ->
    $http.post "/player/station/#{station.ID}"
    @nowPlaying.station = station
    @nowPlaying.isPlaying = true
    $rootScope.$broadcast 'nowPlayingChanged'

  pause: ->
    $http.post '/player/pause'
    @nowPlaying.isPlaying = !(@nowPlaying.isPlaying)
    $rootScope.$broadcast 'nowPlayingChanged'

  updateNowPlaying: (callback) ->
    $http
      .get '/player/nowPlaying'
      .success (data) =>
        @nowPlaying = data
        $rootScope.$broadcast 'nowPlayingChanged'
        callback(data)

  getGenres: (callback) ->
    $http
      .get '/genres/'
      .success (data) ->
        callback(data)
]