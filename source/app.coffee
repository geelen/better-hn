app = angular.module('hnlulz', [])

app.controller "Main", ($scope, $http, $timeout) ->
  $http.get("/hn.json").success (data) ->
    $scope.articles = data

  show = (article, url) ->
    $scope.selectedArticle = article
    $scope.selectedUrl = ""
    event.stopPropagation()
    event.preventDefault()
    $timeout (-> $scope.selectedUrl = url), 0

  $scope.show = (article, event) ->
    show article, article.link
  $scope.showComments = (article, event) ->
    show article, "http://news.ycombinator.com/#{article.comments_link}"

  $scope.articleClass = (article) ->
    'selected' if $scope.selectedArticle == article
