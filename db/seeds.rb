Role.create(name: 'Professor responsável')
Role.create(name: 'Professor de TCC 1')
Role.create(name: 'Professor')
Teacher.create(name: 'Diego Marczal', lattes: 'http://lates.cnpq.br', atuacao: 'Programação web', email: 'ericodias1@gmail.com', login: 'responsavel', role: Role.find_by(:name => "Professor responsável"))
Teacher.create(name: 'Guilherme Silva', lattes: 'http://lates.cnpq.br', atuacao: 'Programação web', email: 'ericodias1@gmail.com', login: 'tcc1', role: Role.find_by(:name => "Professor de TCC 1"))
TypeApproval.create(name: "Aprovado")
TypeApproval.create(name: "Aprovado com restrições")
StatusItem.create name: "Pendente"
StatusItem.create name: "Nenhum"
StatusItem.create name: "Aprovado"
StatusItem.create name: "Reprovado"
StatusItem.create name: "Entrega em breve"
StatusItem.create name: "Data expirada"