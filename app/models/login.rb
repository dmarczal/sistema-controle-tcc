class Login < ActiveRecord::Base
  validates :login, :presence => {message: 'Especifique um login.'}
  validates :login, :uniqueness => {message: 'Login já existe.'}
  validates :password, :presence => {message: 'Especifique um password.'}
  # 1 -> professor responsável, 2 -> professor de TCC 1, 3 -> professor, 4 -> acadêmico
  validates :access, :presence => {message: 'Especifique um tipo de acesso.'}
  # entidade = id do: professor em caso de :access == 1 || 2 || 3, ou estudante em caso de :access == 4
  validates :entity_id, :presence => {message: 'Especifique a entidade.'}

  def getData
    json = Hash.new
    json[:homeUrl] = case self.access
                      when 1 then '/responsavel'
                      when 2 then '/tcc1'
                      when 3 then '/professor'
                      when 4 then '/academico'
                    end
    user = case self.access
             when 1..3 then Teacher.find self.entity_id
             when 4 then Student.find self.entity_id
           end
    json[:user] = user.attributes.to_hash
    json[:user]['password'] = self.password
    if self.access == 4
      json[:user]['access'] = 'student'
    end
    json
  end
end
