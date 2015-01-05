do(angular) ->
  # a palette
  angular.module('colorBrewer').directive 'colorBrewerPalette', (colorBrewer) ->
    restrict: 'E'
    scope:
      paletteName: '@cbPaletteName'
      size: '@cbSize'
      horizontal: '@cbHorizontal'
      range: '@cbRange'
      isReverse: '@cbReverse'
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
        scope.palette = colorBrewer[value][scope.range].reverse(scope.isReverse)
      scope.$watch 'isReverse', (value) ->
        scope.palette = colorBrewer[scope.paletteName][scope.range].reverse(value)

      scope.$watch 'range', (value) ->
        scope.range = value
        scope.palette = colorBrewer[scope.paletteName][value].reverse(scope.isReverse)
      
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
      range: '@cbRange'
    template: '''
      <div class='color-brewer-container'>
        Range: <select ng-options='value for value in [3,4,5,6,7,8,9,10,11,12]' ng-model='range'></select><br />
        Reverse: <input type='checkbox' ng-model='isReverse'>
        <ul>
          <li ng-repeat='(name, palette) in palettes | cbExist:range '>
            <color-brewer-palette 
              cb-palette-name='{{ name }}'
              cb-horizontal='{{ true }}'
              cb-size='{{ size }}'
              cb-range='{{ range }}'
              cb-reverse='{{ isReverse }}'
              class='palette'
              ng-click='callback({paletteName: name, range: range, palette: palette})'
            />
          </li>
        </ul>
      </div>
    '''
    link: (scope, element) ->
      scope.isReverse = false
      scope.$watch 'range', (value) ->
        scope.range = parseInt value

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
        cb-picker-callback='callback(paletteName, range, palette)'
        cb-horizontal='true'
        cb-size='20'
        cb-range='{{ selectedRange }}'
        cb-reverse='{{ false }}'
        ng-show='showList'
      />
    '''
    link: (scope) ->
      scope.callback = (paletteName, range, palette) ->
        scope.parentCallback({paletteName: paletteName, range: range, palette: palette})
        scope.selectedPalette = paletteName
        scope.selectedRange = range
        scope.showList = false

      scope.showList = false
      scope.toggleList = ->
        scope.showList = not scope.showList

