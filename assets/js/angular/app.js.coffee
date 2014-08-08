window.app = angular.module('player', [])

app.controller 'StationsController', ['$scope', 'Player', 'Genres', ($scope, Player, Genres) ->
  $scope.genres = Genres

  $scope.getStations = (genreName) ->
    $scope.loadingStations = true
    Player.getStations genreName, (stations)->
      $scope.loadingStations = false
      $scope.stations = stations

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
      .get "/genre/#{genreName}/stations"
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

  return
]