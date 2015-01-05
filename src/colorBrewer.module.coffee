do (angular) ->
  angular.module 'colorBrewer', []

  require './colorBrewer.filter.js'
  require './colorBrewer.directives.js'
  require './colorBrewer.service.js'

  return
