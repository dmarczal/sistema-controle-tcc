# Preview all emails at http://localhost:3000/rails/mailers/users_mailer
class UsersMailerPreview < ActionMailer::Preview
    def welcome_email
        UsersMailer.newUser(Student.first)
    end
end
