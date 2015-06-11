# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(name: 'Professor responsável')
Role.create(name: 'Professor de TCC 1')
Role.create(name: 'Professor')
Teacher.create(name: 'Diego Marczal', lattes: 'http://lates.cnpq.br', atuacao: 'Programação web', email: 'email@email.com', login: 'diego', role: Role.find_by(:name => "Professor responsável"))
TypeApproval.create(name: "Aprovado")
TypeApproval.create(name: "Aprovado com restrições")
StatusItem.create name: "Pendente"
StatusItem.create name: "Aprovado"
StatusItem.create name: "Reprovado"
StatusItem.create name: "Entrega em breve"