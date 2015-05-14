namespace :db do
  desc "Populate database"
  task populate: :environment do
    require 'populator'
    require 'faker'

    Student.populate 50 do |student|
        student.name = Faker::Name.name
        student.email = Faker::Internet.email
        student.login = Faker::Internet.user_name
        student.ra = Faker::Code.ean
    end

    p 'Db populated'
  end

end
