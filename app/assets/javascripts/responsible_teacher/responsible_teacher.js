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
                that.currentStudent.password = (function(){g=function(){c='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';p='';for(i=0;i<8;i++){p+=c.charAt(Math.floor(Math.random()*62));}return p;};p=g();while(!/[A-Z]/.test(p)||!/[0-9]/.test(p)||!/[a-z]/.test(p)){p=g();}return p;})();
                $http.post(url, {student: that.currentStudent}).success(that.successMethod);
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
                that.currentTeacher.password = (function(){g=function(){c='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';p='';for(i=0;i<8;i++){p+=c.charAt(Math.floor(Math.random()*62));}return p;};p=g();while(!/[A-Z]/.test(p)||!/[0-9]/.test(p)||!/[a-z]/.test(p)){p=g();}return p;})();
                $http.post(url, {teacher: that.currentTeacher}).success(that.successMethod);
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
        that.years = [];
        for(var i=2015; i < 2025; i++) that.years.push(i);
        that.tccs = [1, 2];
        that.halfs = [1, 2];
        that.calendar = {year: new Date().getFullYear(), half: 1, tcc: 1};

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

        that.save = function(item){
            var date = new Date(item.date);
            var day = date.getDate();
            var month = (date.getMonth()+1);
            var year = date.getFullYear();
            item.date = day+'-'+month+'-'+year;

            if(item.id != '#'){
                // editar
                $http.put('/api/timeline/base/item/edit', {item: item}).success(that.successMethod);
            }else{
                // criar
                $http.post('/api/timeline/base/item/new', {item: item, base: that.calendar}).success(that.successMethod);
            }
        }

        that.deleteItem = function(item){
            if(item && item.id != '#'){
                if(window.confirm("Deseja excluir realmente o item?")){
                    $http.delete('/api/timeline/base/item/delete/'+item.id).success(that.successMethod);
                }
            }else if(item && item.id == '#'){
                for(var i = that.items.length - 1; i >= 0; i--) {
                    if(that.items[i] === item) {
                       that.items.splice(i, 1);
                    }
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
        that.updateStudents();

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