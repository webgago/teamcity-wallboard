Wallboard = angular.module('wallboard', ['wallboard.services']).
    config(['$routeProvider', function ($routeProvider, $locationProvider) {
    $routeProvider.
        when('/teamcity', {templateUrl:'teamcity/builds.html', controller:BuildsCtrl})
        .when('/teamcity/:id', {templateUrl:'teamcity/build.html', controller:BuildCtrl})
        .otherwise({redirectTo:'/teamcity'});

}]);

Wallboard.directive('afterRender', function () {
    return function (scope, elm, attr) {
        scope.afterRender(elm, attr);
    };
});


function BuildsCtrl($scope, Builds) {
    var update_builds = function () {
        if(_($scope.running).isEmpty())
            $scope.builds = Builds.query();
        setTimeout(update_builds, 1000 * 60 * 1);
    };
    update_builds();
}

function BuildCtrl($scope, RunningBuilds) {
    var build = $scope.$parent.build
    var update_running = function () {
        RunningBuilds.query(function (running) {
            $scope.running = running;
            build.state = 'complete';

            $scope.running = running;
            build.running = _(running).find(function (r) {
                return build.type == r.type
            });

            if(build.running) {
                build.percentage = build.running.percentage;
                build.start_date = build.running.start_date;
                build.state = 'running'
                build.time_ago = $.timeago(build.start_date);
            }
        });

        setTimeout(update_running, 1000 * 10);
    };

    build.time_ago = $.timeago(build.start_date);
    update_running();
}
