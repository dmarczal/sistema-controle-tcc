class UsersMailer < ApplicationMailer
    default from: 'ericodias1@gmail.com'

    def newUser(user)
        @user = user
        @login = user.login
        @baseUrl = 'http://tcc.tsi.gp.utfpr.edu.br'
        mail(to: @user.email, subject: "Novo usuário no SGTCC - UTFPR")
    end

    def notificateTeacher(student, teacher, item)
        @student = student
        @teacher = teacher
        @item = item
        @baseUrl = 'http://tcc.tsi.gp.utfpr.edu.br'
        subject = student.name+' realizou uma entrega - SGTCC'
        mail(to: @teacher.email, subject: subject)
    end
end