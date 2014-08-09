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
  $scope.$on 'stationChanged', ->
    $scope.nowPlaying = Player.nowPlaying

  $scope.pause = ->
    Player.pause()

  updateNowPlaying = ->
    Player.getCurrentTrack (nowPlaying) ->
      $scope.nowPlaying = nowPlaying unless nowPlaying.stopped
      $timeout(updateNowPlaying, 2000);

  updateNowPlaying()
]


app.service 'Player', ['$rootScope', '$http', ($rootScope, $http) ->
  @getStations = (genreName, callback) ->
    $http
      .get "/genres/#{genreName}/stations"
      .success (data) ->
        callback(data)

  @playStation = (station) ->
    @nowPlaying = station
    $rootScope.$broadcast 'stationChanged'
    $http.post "/player/station/#{station.ID}"

  @pause = ->
    $http.post '/player/pause'

  @getCurrentTrack = (callback) ->
    $http
      .get '/player/station/current/track'
      .success (data) ->
        callback(data)

  @getGenres = (callback) ->
    $http
      .get '/genres/'
      .success (data) ->
        callback(data)


  return
]