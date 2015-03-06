(function(){
    var app = angular.module('Application', ['MessageCenterModule']);

    app.controller('FlashController', ['$http', 'messageCenterService', function($http, messageCenterService){
        $http.get('/api/messages').success(function(messages){
            for(var i=0; i < messages.length; i++){
                messageCenterService.add(messages[i][0], messages[i][1]);
            }
        });
    }]);

    app.controller('LoginController', ['$http', 'messageCenterService', function($http, messageCenterService){
        var that = this;
        that.login = 'diego';
        that.password = '123';

        that._login = function(){
            if(that.login && that.password){
                $http.post('/api/login', {login: that.login, password: that.password}).success(function(data){
                    if(data.success){
                        window.location = data.success[0];
                    }else{
                        messageCenterService.add('danger', data.errors[0]);
                    }
                });
            }
        }
    }]);
})();