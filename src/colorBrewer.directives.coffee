do(angular) ->
  # a palette
  angular.module('colorBrewer').directive 'colorBrewerPalette', (colorBrewer) ->
    restrict: 'E'
    scope:
      paletteName: '@cbPaletteName'
      size: '@cbSize'
      horizontal: '@cbHorizontal'
      range: '@cbRange'
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
    link: (scope,e,attributes) ->
      scope.$watch 'paletteName', (value) ->
        scope.palette = colorBrewer[scope.paletteName][scope.range]

      # scope.$watch 'range', (value) ->
      #   console.log value
      
      # scope.range = if scope.range? then scope.range else 0
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
          cb-palette-name='{{ name }}'
          cb-horizontal='{{ true }}'
          cb-size='{{ size }}'
          cb-range='{{ palette.length }}'
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
      selectedPalette: '@cbInitialPaletteName'
      selectedRange: '@cbInitialRange'
    template: '''
      <div class='palette-selector' 
        ng-click='toggleList()'
      >
        <color-brewer-palette 
          cb-palette-name='{{ selectedPalette }}'
          cb-horizontal='{{ true }}'
          cb-size='{{ 20 }}'
          cb-range='{{ selectedRange }}'
          class='palette'
        ></color-brewer-palette>
        <span class='caret'></span>
      </div>

      <color-brewer-picker 
        cb-picker-callback='callback(paletteName, selectedRange, palette)'
        cb-horizontal='true'
        cb-size='20'
        ng-show='showList'
      />
    '''
    link: (scope) ->
      scope.callback = (paletteName, range, palette) ->
        scope.selectedPalette = paletteName
        scope.parentCallback({paletteName: paletteName, range: range, palette: palette})
        scope.showList = false

      scope.showList = false
      scope.toggleList = ->
        scope.showList = not scope.showList

