app = angular.module('hnlulz', [])

app.controller "Main", ($scope, $http, $timeout) ->
  $http.get("/hn.json").success (data) ->
    $scope.articles = data

  $scope.show = (article) ->
    $scope.selectedArticle = article
    $scope.selectedUrl = article.link

  $scope.articleClass = (article) ->
    'selected' if $scope.selectedArticle == article
