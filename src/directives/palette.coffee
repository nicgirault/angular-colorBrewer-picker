# a palette
angular.module('colorBrewer').directive 'palette', (colorBrewer) ->
  restrict: 'E'
  scope:
    palette: '=colors'
    size: '@size'
  templateUrl: 'templates/palette.html'
