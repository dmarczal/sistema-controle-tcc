class UsersMailer < ApplicationMailer
    default from: 'ericodias1@gmail.com'

    def newUser(user)
        @user = user
        @login = user.login
        @baseUrl = 'http://tcc.tsi.gp.utfpr.edu.br'
        mail(to: @user.email, subject: "Novo usuário no SGTCC - UTFPR")
    end
end
