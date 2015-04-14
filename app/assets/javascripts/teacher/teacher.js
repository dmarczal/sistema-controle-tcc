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

    app.controller('TimelineController', ['$http', 'messageCenterService', function($http, messageCenterService){
        var that = this;
        var cookies = document.cookie.split('=');
        that.teacher = JSON.parse(cookies[1]);

        that.years = [2010, 2011, 2012, 2013, 2014, 2015];
        that.tccs = [1, 2];
        that.halfs = [1, 2];
        that.year = 2015;
        that.half = 1;
        that.tcc = 1;
        that._ctrlForm = false;

        $http.get('/api/student/all').success(function(data){
            that.allStudents = data;
        });

        $http.get('/api/teacher/all').success(function(data){
            that.allTeachers = data;
        });

        that.updateStudents = function(){
            if(that.year && that.half && that.tcc){
                $http.get('/api/timeline/find/teacher/'+that.teacher.id+'/'+that.year+'/'+that.half+'/'+that.tcc).success(function(data){
                    if(data.timelines){
                        that.timelines = data.timelines;
                    }else if(data.errors){
                        messageCenterService.add('danger', 'Nenhum TCC encontrado.', {timeout: 3000});
                    }
                });
            }
        }
        that.updateStudents();

        that.updateTimeline = function(){
            $http.get('/api/timeline/base/search/'+ that.year+'/'+ that.half+'/'+ that.tcc).success(function(data){
                base_calendar = data.data;
                if(that.timeline){
                    header(base_calendar.json, that.timeline.items, that.half, function(){
                        body(that.timeline.items);
                        events(that.timeline.items);
                        that._ctrlTimeline = true;
                    });
                }
            });
        }
    }]);
})();