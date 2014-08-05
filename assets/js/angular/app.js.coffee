window.app = angular.module('player', [])

app.controller 'StationsController', ['$scope', 'Player', 'Genres', ($scope, Player, Genres) ->
  $scope.genres = Genres

  $scope.getStations = (genreName) ->
    Player.getStations genreName, (stations)->
      $scope.stations = stations

  $scope.playStation = (station) ->
    Player.playStation station
]

app.controller 'PlayerController', ['$scope', 'Player', ($scope, Player) ->
  $scope.$on 'stationChanged', ->
    $scope.nowPlaying = Player.nowPlaying
]



app.service 'Player', ['$rootScope', '$http', ($rootScope, $http) ->
  @getStations = (genreName, callback) ->
    $http
      .get("/genre/#{genreName}/stations")
      .success (data) ->
        callback(data)

  @playStation = (station) ->
    $http.post("/player/station/#{station.ID}")
    @nowPlaying = station
    $rootScope.$broadcast 'stationChanged'

  return
]