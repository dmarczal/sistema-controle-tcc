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
end
