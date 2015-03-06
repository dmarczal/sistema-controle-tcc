(function(){
    var app = angular.module('Application');

    app.controller('StudentController', ['$http', 'messageCenterService',function($http, messageCenterService){
        var that = this;
        var _formStudent = false;
        var currentStudent = null;
        var inEditing = false;

        that.refreshItems = function(){
            $http.get('/api/student/all').success(function(data){
                that.students = data;
            });
        };

        that.refreshItems();

        that.formStudent = function(student){
            if(student){
                that.currentStudent = student;
                that.inEditing = true;
            }else{
                that.currentStudent = null;
                that.inEditing = false;
            }
            that._formStudent = true;
        }

        that.listStudents = function(){
            that._formStudent = false;
        }

        that.newStudent = function(){
            if(that.inEditing){
                var url = '/api/student/edit/'+that.currentStudent.id;
                $http.put(url, that.currentStudent).success(that.successMethod);
            }else{
                var url = '/api/student/new';
                $http.post(url, that.currentStudent).success(that.successMethod);
            }
        }

        that.deleteStudent = function(student){
            if(window.confirm("Tem certeza que deseja excluir o aluno com RA = "+student.ra+"?")){
                var url = '/api/student/delete/'+student.id;
                $http.delete(url).success(that.successMethod)
                student = null;
            }
        }

        that.successMethod = function(data){
            if(data.success){
                messageCenterService.add('success', 'Operação realizada com sucesso.', {timeout: 3000});
                that.refreshItems();
                that.listStudents();
            }else{
                for(var i in data.errors){
                    messageCenterService.add('danger', data.errors[i][0], {timeout: 3000});
                }
            }
        }
    }]);

    app.controller('TeacherController', ['$http', 'messageCenterService',function($http, messageCenterService){
        var that = this;
        var _formTeacher = false;
        var currentTeacher = null;
        var inEditing = false;


        that.refreshItems = function(){
            $http.get('/api/teacher/all').success(function(data){
                for(i in data){
                    var legendAccess = {
                        teacher: "Professor", responsible: "Professor responsável pelo TCC", tcc1: "Professor de TCC1"
                    };
                    data[i].legendAccess = legendAccess[data[i].access];
                }
                that.teachers = data;
            });
        };

        that.refreshItems();

        that.formTeacher = function(teacher){
            if(teacher){
                that.currentTeacher = teacher;
                that.inEditing = true;
            }else{
                that.currentTeacher = null;
                that.inEditing = false;
            }
            that._formTeacher = true;
        }

        that.listTeachers = function(){
            that._formTeacher = false;
        }

        that.newTeacher = function(){
            if(that.inEditing){
                //that.currentTeacher.id = '1231287164783925';
                var url = '/api/teacher/edit/'+that.currentTeacher.id;
                $http.put(url, that.currentTeacher).success(that.successMethod);
            }else{
                var url = '/api/teacher/new';
                $http.post(url, that.currentTeacher).success(that.successMethod);
            }
        }

        that.deleteTeacher = function(teacher){
            if(window.confirm("Tem certeza que deseja excluir o professor "+teacher.name+"?")){
                var url = '/api/teacher/delete/'+teacher.id;
                $http.delete(url).success(that.successMethod);
                teacher = null;
            }
        }

        that.successMethod = function(data){
            if(data.success){
                messageCenterService.add('success', 'Operação realizada com sucesso.', {timeout: 3000});
                that.refreshItems();
                that.listTeachers();
            }else{
                for(var i in data.errors){
                    messageCenterService.add('danger', data.errors[i][0], {timeout: 3000});
                }
            }
        }
    }]);

    app.controller('CalendarController', ['$http', '$scope', 'messageCenterService', function($http, $scope, messageCenterService){
        var that = this;
        that._ctrlContent = false;
        that.years = [2010, 2011, 2012, 2013, 2014, 2015];
        that.tccs = [1, 2];
        that.halfs = [1, 2];
        that.calendar = {};

        that._baseItem = {
            id: '#',
            title: '',
            _type: '',
            date: '',
            link: '',
            description: ''
        };
        that.items = [];

        that.updateTable = function(){
            if(that.calendar.year && that.calendar.tcc && that.calendar.half){
                var c = that.calendar;
                $http.get('/api/timeline/base/search/'+ c.year+'/'+ c.half+'/'+ c.tcc).success(function(data){
                    if(!data.errors){
                        that.calendar.id = data.data.id;
                        that.calendar.json = data.data.json;
                        var items = [];
                        for(i in data.data.items){
                            var item = data.data.items[i];
                            var date = item.date.split('-');
                            items.push({
                                id: item.id,
                                title: item.title,
                                _type: item._type,
                                date: new Date(date[0], date[1]-1, date[2]),
                                link: item.link,
                                description: item.description
                            });
                        }
                        items.push(JSON.parse(JSON.stringify(that._baseItem)));
                        that.items = items;
                        that._items = JSON.parse(JSON.stringify(items));
                        that._ctrlContent = true;
                    }else{
                        that.items = [JSON.parse(JSON.stringify(that._baseItem))];
                        that._ctrlContent = true;
                        //that.calendar = {};
                    }
                });
            }
        };
        that.updateTable();

        that.save = function(){
            var calendar = JSON.parse(JSON.stringify(that.calendar));
            var items = JSON.parse(JSON.stringify(that.items));
            for(i in items){
                if(items[i].title.length){
                    var date = new Date(items[i].date);
                    var day = date.getDate();
                    var month = (date.getMonth()+1);
                    var year = date.getFullYear();
                    items[i].date = day+'-'+month+'-'+year;
                }else{
                    delete items[i];
                    items.splice(i);
                }
            }
            calendar.items = items;

            for(var i in calendar.items){
                if(calendar.items[i] == that._baseItem){
                    delete calendar.items[i];
                    calendar.items.splice(i);
                }
            }

            if(calendar.id){
                // editar
                $http.put('/api/timeline/base/edit', {base: calendar}).success(that.successMethod);
            }else{
                // criar
                $http.post('/api/timeline/base/new', {base: calendar}).success(that.successMethod);
            }
        }

        that.deleteItem = function(id){
            for(i in that.items){
                if(that.items[i] && that.items[i].id == id){
                    delete that.items[i];
                    that.items = that.items.filter(function(item){ return item == null ? false : true; });
                    if(id == '#') that.items.push(JSON.parse(JSON.stringify(that._baseItem)));
                }
            }
        }

        that.successMethod = function(data){
            if(!data.errors){
                messageCenterService.add('success', 'Operação realizada com sucesso.', {timeout: 5000});
                that.updateTable();
            }else{
                for(var i in data.errors){
                    messageCenterService.add('danger', data.errors[i][0], {timeout: 5000});
                }
            }
        }

        that.editTimeline = function(){
            that._ctrlContent = 2;
            header(that.calendar.json, that._items, that.calendar.half, function(){
                body(that._items);
            });
        }

        that.saveTimeline = function(){
            $http.post('/api/timeline/base/json/'+that.calendar.id,{json:JSON.stringify(canvas.toDatalessJSON(['event_id', 'fill']))}).success(that.successMethod);
        }
    }]);

    app.controller('TimelineController', ['$http', 'messageCenterService', function($http, messageCenterService){
        var that = this;
        that.years = [2010, 2011, 2012, 2013, 2014, 2015];
        that.tccs = [1, 2];
        that.halfs = [1, 2];
        that._ctrlForm = false;

        $http.get('/api/student/all').success(function(data){
            that.allStudents = data;
        });

        $http.get('/api/teacher/all').success(function(data){
            that.allTeachers = data;
        });

        that.saveTimeline = function(){
            $http.post('/api/timeline/new', {timeline: that.newTimeline}).success(function(data){
                if(data.success){
                    messageCenterService.add('success', 'Operação realizada com sucesso.', {timeout: 3000});
                }else{
                    for(var i in data){
                        messageCenterService.add('danger', data[i][0], {timeout: 3000});
                    }
                }
            });
        }

        that.updateStudents = function(){
            if(that.year && that.half && that.tcc){
                $http.get('/api/timeline/find/'+that.year+'/'+that.half+'/'+that.tcc).success(function(data){
                    if(data.timelines){
                        that.timelines = data.timelines;
                    }else if(data.errors){
                        messageCenterService.add('danger', 'Nenhum TCC encontrado.', {timeout: 3000});
                    }
                });
            }
        }

        that.updateTimeline = function(){
            $http.get('/api/timeline/base/search/'+ that.year+'/'+ that.half+'/'+ that.tcc).success(function(data){
                base_calendar = data.data;
                header(base_calendar.json, that.timeline.items, that.half, function(){
                    body(that.timeline.items);
                    events(that.timeline.items);
                    that._ctrlTimeline = true;
                });
            });
        }
    }]);
})();