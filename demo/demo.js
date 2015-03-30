'use strict';

var app = angular.module('demo', ['colorBrewer', 'ui.select', 'ngSanitize']);

app.controller('DemoCtrl', function($scope, colorBrewer) {
  $scope.palettes = colorBrewer
});
