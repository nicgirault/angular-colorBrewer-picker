do (angular) ->
    # reverse if argument is true
    angular.module('colorBrewer').filter 'cbExist', (colorBrewer) ->
      (input, range) ->
        out = {}
        for name, palette of input
          if colorBrewer[name][range]?
            out[name] = palette
        return out
