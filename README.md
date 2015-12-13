angular-colorBrewer-picker
==========================

An Angular stand-alone module to select a [color Brewer](http://colorbrewer2.org/) palette.

[Demo](http://plnkr.co/edit/aoDgRw3tu8VApuZ651tc?p=preview)

## Install

```shell
bower install --save angular-colorBrewer-selector
```

## Usage

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">

    <script src="angular.min.js"></script>
    <script src="angular-color-brewer-picker.min.js"></script>

    <link rel="stylesheet" href="bootstrap.min.css">
    <link rel="stylesheet" href="angular-color-brewer-picker.min.css">

    <script>
      angular.module('demo', ['colorBrewer'])
      .controller('demoCtrl', function($scope) {
        $scope.onSelect = function(item, isReverse){
          console.log(item, isReverse);
        };
      });
    </script>
  </head>

  <body ng-app="demo">
    <div ng-controller="demoCtrl">
      <div>
        <palette-picker
          initial-name='Blues'
          initial-range='4'
          initial-reverse='false'
          on-select='onSelect(item, isReverse)'
        />
      </div>
    </div>
  </body>
</html>
```
