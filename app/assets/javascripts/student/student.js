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

    app.controller('TimelineController', ['$http', 'messageCenterService', function($http, messageCenterService){
        var that = this;
        var cookies = document.cookie.split('=');
        that.student = JSON.parse(cookies[1]);
        that.tcc = 1;
        that._ctrlForm = false;

        that.updateTimeline = function(){
            $http.get('/api/timeline/find/'+that.student.id+'/'+that.tcc).success(function(data){
                if(!data.errors){
                    that._ctrlTimeline = true;
                    that.timeline = data.timeline;
                    base_calendar = that.timeline.base_timeline;
                    header(base_calendar.json, that.timeline.items, that.half, function(){
                        body(that.timeline.items);
                        events(that.timeline.items);
                        that._ctrlTimeline = true;
                    });
                }else{
                    messageCenterService.add('warning', 'Este TCC ainda não foi cadastrado.', {timeout: 3000});
                    that._ctrlTimeline = false;
                }
            });
        }

        that.updateTimeline();
    }]);
})();