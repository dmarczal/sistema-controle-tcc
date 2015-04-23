class UsersMailer < ApplicationMailer
    default from: 'ericodias1@gmail.com'

    def newUser(user)
        @user = user
        @login = user.login
        @baseUrl = 'http://tcc.tsi.gp.utfpr.edu.br'
        mail(to: @user.email, subject: "[SGTCC] Novo usuário")
    end

    def notificateTeacher(student, teacher, item)
        @student = student
        @teacher = teacher
        @item = item
        @baseUrl = 'http://tcc.tsi.gp.utfpr.edu.br'
        subject = '[SGTCC] '+student.name+' realizou uma entrega'
        mail(to: @teacher.email, subject: subject)
    end

    def approveRepproveItem(student, itemBase, item)
        @student = student
        @item = item
        @itemBase = itemBase
        @baseUrl = 'http://tcc.tsi.gp.utfpr.edu.br'
        subject = '[SGTCC] Olá, '+student.name+'. Você tem uma nova atualização'
        mail(to: @student.email, subject: subject)
    end
end