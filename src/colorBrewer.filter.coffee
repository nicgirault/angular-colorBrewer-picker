do (angular) ->
    # reverse if argument is true
    angular.module('colorBrewer').filter 'cbExist', ->
      (colorBrewer, range) ->
        out = {}
        for name, palette of colorBrewer
          if colorBrewer[name][range]?
            out[name] = palette
        return out
