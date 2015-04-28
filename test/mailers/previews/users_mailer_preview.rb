# Preview all emails at http://localhost:3000/rails/mailers/users_mailer
class UsersMailerPreview < ActionMailer::Preview
    def welcome_email
        UsersMailer.newUser(Student.first)
    end

    def notificate_teacher
        item = ItemTimeline.find(8)
        teacher = item.timeline.teacher
        student = item.timeline.student
        itemBase = item.item_base_timeline
        UsersMailer.notificateTeacher(student, teacher, itemBase)
    end

    def approve_reprove
        item = ItemTimeline.find(8)
        itemBase = item.item_base_timeline
        student = item.timeline.student
        UsersMailer.approveRepproveItem(student, itemBase, item)
    end

    def notifyStudentItNewBank
       UsersMailer.notifyStudentItNewBank(Bank.first)
    end

    def notifyTeacherItNewBank
       UsersMailer.notifyTeacherItNewBank(Bank.first)
    end
end
