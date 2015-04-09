(function(){
    var app = angular.module('Application');

    app.controller('StudentController', ['$http', '$location', 'messageCenterService', 'fileUpload', function($http, $location, messageCenterService, fileUpload){
        var that = this;
        var cookies = document.cookie.split('=');
        that.student = cookies[1];

        $http.get('/api/timeline/item/get/'+$location.path().replace('/', '')).success(function(data){
            that.item = data;
        });

        that.sendFile = function(){
            var file = that.itemFile;
            fileUpload.uploadFileToUrl(file, '/api/timeline/item/send/'+that.item.id, function(data){
                if(data.success){
                    messageCenterService.add('success', 'Operação realizada com sucesso.', {timeout: 3000});
                }else{
                    messageCenterService.add('danger', 'Ops, algum erro aconteceu!', {timeout: 3000});
                }
            });
        }
    }]);

    app.directive('fileModel', ['$parse', function ($parse) {
        return {
            restrict: 'A',
            link: function(scope, element, attrs) {
                var model = $parse(attrs.fileModel);
                var modelSetter = model.assign;

                element.bind('change', function(){
                    scope.$apply(function(){
                        modelSetter(scope, element[0].files[0]);
                    });
                });
            }
        };
    }]);

    app.service('fileUpload', ['$http', function ($http) {
        this.uploadFileToUrl = function(file, uploadUrl, success){
            var fd = new FormData();
            fd.append('file', file);
            $http.post(uploadUrl, fd, {
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            })
            .success(function(data){
                success(data);
            })
            .error(function(){
            });
        }
    }]);
})();