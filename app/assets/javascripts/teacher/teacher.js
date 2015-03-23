(function(){
    var app = angular.module('Application');

    app.controller('TeacherController', ['$http', '$location', 'messageCenterService', function($http, $location, messageCenterService){
        var that = this;
        var cookies = document.cookie.split('=');
        that.teacher = JSON.parse(cookies[1]);

        that.updateTable = function(){
            $http.get('/api/teacher/pending/'+that.teacher.id).success(function(data){
                if(data.length){
                    that.items = data;
                    that._ctrlTable = true;
                }else{
                    that.items = {};
                }
            });
        }
        that.updateTable();

        that.approve = function(id){
            $http.get('/api/teacher/document/approve/'+id).success(function(data){
                if(data.success){
                    messageCenterService.add('success', 'Operação realizada com sucesso.', {timeout: 3000});
                }else{
                    messageCenterService.add('danger', 'Ops, algum erro aconteceu!', {timeout: 3000});
                }
                that.updateTable();
            });
        }

        that.reprove = function(id){
            $http.get('/api/teacher/document/reprove/'+id).success(function(data){
                if(data.success){
                    messageCenterService.add('success', 'Operação realizada com sucesso.', {timeout: 3000});
                }else{
                    messageCenterService.add('danger', 'Ops, algum erro aconteceu!', {timeout: 3000});
                }
                that.updateTable();
            });
        }
    }]);
})();