namespace :db do
  desc "Populate database"
  task populate: :environment do
    require 'populator'
    require 'faker'

    [Student, Teacher].each(&:delete_all)

    Student.populate 50 do |student|
        student.name = Faker::Name.name
        student.email = Faker::Internet.email
        student.login = Faker::Internet.user_name
        student.ra = Faker::Code.ean
    end

    Teacher.populate 50 do |teacher|
      teacher.name = Faker::Name.name
      teacher.atuacao = ['Programação web', 'Dispositivos móveis', 'Banco de dados']
      teacher.lattes = Faker::Internet.url('lattes.cnpq.br')
      teacher.email = Faker::Internet.email
      teacher.login = Faker::Internet.user_name
      teacher.role_id = Role.ids
    end

    p 'Db populated'
  end

end
