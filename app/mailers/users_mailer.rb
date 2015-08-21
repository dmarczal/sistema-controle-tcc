class UsersMailer < ApplicationMailer
    default from: 'tccutfprgpuava@gmail.com'

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

    def notifyStudentItNewBank(bank)
        @student = bank.timeline.student
        @bank = bank
        @calendar = bank.timeline.base_timeline
        @teachers = bank.teachers
        subject = '[SGTCC] Sua banca de TCC foi marcada'
        mail(to: @student.email, subject: subject)
    end

    def notifyTeacherItNewBank(bank)
        @student = bank.timeline.student
        @bank = bank
        @calendar = bank.timeline.base_timeline
        @teachers = bank.teachers
        subject = '[SGTCC] Sua banca de TCC foi marcada'
        @teachers.each do |teacher|
            @teacher = teacher
            mail(to: @teacher.email, subject: subject)
        end
    end
end