do (angular) ->
  angular.module 'colorBrewer', []

  require './colorBrewer.directives.js'
  require './colorBrewer.service.js'
  require './colorBrewer.filter.js'

  return
