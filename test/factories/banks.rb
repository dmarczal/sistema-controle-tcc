FactoryGirl.define do
  factory :bank do
    date 2.days.ago
    timeline_id 1
    teacher_ids {create_list(:teacher, 3).map {|t| t.id} } 

    factory :bank_proposta do
      _type 'proposta'
    end

    factory :bank_tcc1 do
      _type 'tcc1'
    end

    factory :bank_tcc2 do
      _type 'tcc2'
    end
  end
end
