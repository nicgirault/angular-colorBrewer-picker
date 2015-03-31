# a palette
angular.module('colorBrewer').directive 'palettePicker', (palettes) ->
  restrict: 'E'
  scope: {}
  templateUrl: 'templates/palette-picker.html'
  link: (scope) ->
    scope.palettes = palettes
    scope.range = 9
    scope.refreshPalettes = (range, reverse) ->
      scope.palettes = palettes
        .filter (palette) ->
          palette.range[range]?
        .map (palette) ->
          palette.range[range]
    scope.reversePalettes = (reverse) ->
        scope.palettes.map (palette) ->
          palette.reverse()
