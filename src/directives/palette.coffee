# a palette
angular.module('colorBrewer').directive 'palette', ->
  restrict: 'E'
  scope:
    palette: '=colors'
    size: '@size'
  templateUrl: 'palette.html'
