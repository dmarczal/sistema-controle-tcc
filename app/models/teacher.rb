class Teacher < ActiveRecord::Base
  has_many :timeline
  has_and_belongs_to_many :banks
  has_many :bank_note
  belongs_to :role

  validates_presence_of :name
  validates_presence_of :role_id
  validates_presence_of :email

  def self.search(search)
    if search
        where(['lower(name) LIKE ?', "%#{search}%".downcase])
    else
        all
    end
  end
end