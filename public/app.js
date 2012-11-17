Wallboard = angular.module('wallboard', ['wallboard.services']).
    config(['$routeProvider', function ($routeProvider, $locationProvider) {
    $routeProvider.
        when('/teamcity', {templateUrl:'teamcity/builds.html', controller:BuildsCtrl})
        .otherwise({redirectTo:'/teamcity'});

}]);

Wallboard.directive('afterRender', function () {
    return function (scope, elm, attr) {
        scope.afterRender(elm, attr);
    };
});

function BuildsCtrl($scope, Builds) {
    $scope.builds = Builds.query();
}

function BuildCtrl($scope) {
    var build = $scope.$parent.build
    build.time_ago = $.timeago(build.start_date);
}
