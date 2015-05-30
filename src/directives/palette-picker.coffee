# a palette
angular.module('colorBrewer').directive 'palettePicker', [ 'palettes', (palettes) ->
  restrict: 'E'
  scope:
    initialPalette: '@'
    initialName: '@'
    initialRange: '@'
    initialReverse: '='
    onSelect: '&'
  templateUrl: 'palette-picker.html'
  link: (scope) ->
    palettes = angular.copy palettes
    if scope.initialReverse
      palettes.map (paletteCluster) ->
        for range, palette of paletteCluster.range
          palette.reverse()

    initialRange = scope.initialRange || 9
    scope.palettes = palettes
      .filter (palette) ->
        palette.range[initialRange]?
      .map (palette) ->
        name: palette.name
        colors: palette.range[initialRange]

    scope.selectedPalette = {name: null, colors: []}
    for palette in palettes
      if palette.name == scope.initialName
        scope.selectedPalette = {name: palette.name, colors: palette.range[initialRange]}
        break

    scope.range = initialRange

    scope.refreshPalettes = (range) ->
      scope.palettes = palettes
        .filter (palette) ->
          palette.range[range]?
        .map (palette) ->
          name: palette.name
          colors: palette.range[range]

    scope.reversePalettes = ->
      palettes.map (paletteCluster) ->
        for range, palette of paletteCluster.range
          palette.reverse()

    scope.selectCallback = (item, isReverse) ->
      scope.onSelect({item: item, isReverse: isReverse})
]
