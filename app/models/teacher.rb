class Teacher < ActiveRecord::Base
  has_many :timelines, through: :teacher_timelines
  has_many :teacher_timelines
  has_and_belongs_to_many :banks
  has_many :bank_note
  has_many :approval
  has_one :password
  belongs_to :role

  validates_presence_of :name
  validates_presence_of :role_id
  validates_presence_of :email

  after_create :create_default_password

  def self.search(search)
    if search
        where(['lower(name) LIKE ?', "%#{search}%".downcase])
    else
        all
    end
  end

  private
  def create_default_password
    Password.create teacher: self, password: 'abc123'
  end
end