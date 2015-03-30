# a palette
angular.module('colorBrewer').directive 'palettePicker', (colorBrewer) ->
  restrict: 'E'
  scope: {}
  templateUrl: 'templates/palette-picker.html'
  link: (scope) ->
    scope.palettes = colorBrewer
    scope.range = 9
    scope.refreshPalettes = (range) ->
      scope.palettes = colorBrewer
        .filter (palette) ->
          palette.range[range]?
        .map (palette) ->
          palette.range[range]

 angular.module('colorBrewer').filter 'cbExist', ->
      (colorBrewer, range) ->
        out = []
        for palette in colorBrewer
          if palette.range[range]?
            out.push palette
        return out
