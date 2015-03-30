# a palette
angular.module('colorBrewer').directive 'palettePicker', (colorBrewer) ->
  restrict: 'E'
  scope: {}
  templateUrl: 'templates/palette-picker.html'
  link: (scope) ->
    scope.palettes = colorBrewer
    scope.range = 9
