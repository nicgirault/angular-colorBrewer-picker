do (angular) ->
  angular.module 'colorBrewer', ['ui.select', 'ngSanitize']
  require './services/palettes.js'
  require './directives/palette.js'
  require './directives/palette-picker.js'
  return
