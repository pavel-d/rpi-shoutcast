window.app = angular.module('player', [])

app.controller 'StationsController', ['$scope', '$http', 'Genres', ($scope, $http, Genres) ->
  $scope.genres = Genres

  $scope.getStations = (genreName) ->
    $http.get("/genre/#{genreName}/stations")
      .success (data) ->
        $scope.stations = data

  $scope.playStation = (station) ->
    $http.post("/player/station/#{station.ID}")
]