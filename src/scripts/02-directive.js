var app = angular.module('bzSwitch', []);

app.directive('bzSwitch', ['$parse', function($parse) {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, element, attrs, ngModel) {
            var callback = $parse(attrs.bzSwitch);

            var onChange = function() {
                ngModel.$setViewValue(checkbox.bootstrapSwitch('status'));
                callback(scope);
                if (!scope.$$phase) {
                    scope.$apply();
                }
            };
            var checkbox = element.wrap('<div class="switch"></div>').parent().bootstrapSwitch();
            ngModel.$render = function(value) {
                checkbox.unbind('change');
                checkbox.bootstrapSwitch('setState', value);
                checkbox.change(onChange);
            };
            scope.$watch(attrs.ngModel, ngModel.$render);
            checkbox.change(onChange);
        }
    };
}]);