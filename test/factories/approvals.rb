 FactoryGirl.define do
   factory :approval do
     association :type_approval, factory: :approved
     association :bank, factory: :bank_proposta

     file_file_name "Projeto-de-TCC-Erico-Dias-Ferreira-2015-01.pdf"
     file_content_type "application/pdf"
     file_file_size 2671901
     file_updated_at "2015-08-30 01:07:28"
   end

   factory :type_approval do
     
     factory :approved do
       name "Aprovado"
     end

     factory :approved_with_restrictions do
       name "Aprovado com restrições"
     end

   end
 end
