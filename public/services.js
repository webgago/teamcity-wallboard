angular.module('wallboard.services', ['ngResource'])
    .factory('Builds', function ($resource) {
        return $resource('teamcity/builds.json', {});
    });
