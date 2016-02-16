FactoryGirl.define do
  factory :role do
    name 'Professor responsável'

    factory :role_teacher do
      name 'Professor'
    end

    factory :role_teacher_tcc1 do
      name 'Professor de TCC 1'
    end
  end

end

