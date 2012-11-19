angular.module('wallboard.services', ['ngResource'])
    .factory('Builds', function ($resource) {
        return $resource('teamcity/builds.json', {});
    })
    .factory('RunningBuilds', function ($resource) {
        return $resource('teamcity/builds/running.json', {});
    });
