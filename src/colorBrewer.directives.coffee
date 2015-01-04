do(angular) ->
  # a palette
  angular.module('colorBrewer').directive 'colorBrewerPalette', ->
    restrict: 'E'
    scope:
      palette: '=cbPalette'
      size: '=cbSize'
      horizontal: '=cbHorizontal'
      range: '=cbRange'
    template: '''
      <svg 
        ng-attr-width='{{ horizontal ? size * range : size }}' 
        ng-attr-height='{{ horizontal ? size : size * range }}'
      >
        <rect
          ng-repeat='color in palette' 
          ng-attr-fill='{{ color }}' 
          ng-attr-width='{{ size }}' 
          ng-attr-height='{{ size }}' 
          ng-attr-x='{{ horizontal ? $index * size : 0 }}' 
          ng-attr-y='{{ horizontal ? 0 : $index * size }}' 
          title='{{ color }}' 
        />
      </svg>
    '''
    link: (scope) ->
      scope.range = if scope.range? then scope.range else 0
      scope.size = if scope.size? then scope.size else 20
      scope.horizontal = if scope.horizontal? then scope.horizontal else true

  # all the palettes
  angular.module('colorBrewer').directive 'colorBrewerPicker', (colorBrewer) ->
    restrict: 'E'
    scope:
      callback: '&cbPickerCallback'
      size: '@cbSize'
      horizontal: '=cbHorizontal'
    template: '''
      <div class='color-brewer-container'>
        <color-brewer-palette 
          ng-repeat='(name, palette) in palettes'
          cb-palette='palette'
          cb-horizontal='horizontal'
          cb-size='size'
          cb-range='palette.length'
          class='palette'
          ng-click='callback({paletteName: name, palette: palette})'
        />
      </div>
    '''
    link: (scope, element) ->
      palettes = {}
      for key, palette of colorBrewer
        for k in [12..3]
          if palette[k]?
            palettes[ key ] = palette[k]
            break
      scope.palettes = palettes

  # a button to toggle the display of all the palettes
  angular.module('colorBrewer').directive 'colorBrewerPickerSelect', ->
    restrict: 'E'
    scope:
      parentCallback: '&cbPickerCallback'
      size: '@cbSize'
      horizontal: '=cbHorizontal'
    template: '''
      <div class='palette-selector' 
        ng-click='toggleList()'
      >
        <color-brewer-palette 
          cb-palette='selectedPalette'
          cb-horizontal='true'
          cb-size='20'
          cb-range='selectedPalette.length'
          class='palette'
        />
        <span class='caret'></span>
      </div>

      <color-brewer-picker 
        cb-picker-callback='callback(paletteName, palette)'
        cb-horizontal='true'
        cb-size='20'
        ng-show='showList'
      />
    '''
    link: (scope) ->
      scope.selectedPalette = []

      scope.callback = (paletteName, palette) ->
        scope.parentCallback({paletteName: paletteName, palette: palette})
        scope.selectedPalette = palette
        scope.showList = false

      scope.showList = false
      scope.toggleList = ->
        scope.showList = not scope.showList

