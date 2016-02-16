 FactoryGirl.define do
   factory :teacher do
     name { Faker::Name.name }
     lattes { Faker::Internet.url}
     atuacao { Faker::Lorem.sentence}
     email { Faker::Internet.email}
     login { Faker::Internet.user_name}
     association :role, factory: :role_teacher
     avaliable true 
   end
 end
