(function(){
    var app = angular.module('Application', ['MessageCenterModule']);

    app.controller('FlashController', ['$http', 'messageCenterService', function($http, messageCenterService){
        $http.get('/api/messages').success(function(messages){
            if(messages.length){
                messages[0][0] = messages[0][0].replace('error', 'danger');
                messageCenterService.add(messages[0][0], messages[0][1], {timeout: 3000});
            }
        });
    }]);

    app.controller('LoginController', ['$http', 'messageCenterService', function($http, messageCenterService){
        var that = this;

        that._login = function(){
            if(that.login && that.password){
                $http.post('/api/login', {login: that.login, password: that.password}).success(function(data){
                    if(data.success){
                        var user = data.success.user;
                        document.cookie = 'username='+JSON.stringify(user);
                        window.location = data.success['homeUrl'];
                    }else{
                        messageCenterService.add('danger', data.errors[0]);
                    }
                });
            }
        }
    }]);
})();
