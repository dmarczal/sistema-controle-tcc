class BankStatus < ActiveRecord::Base
  has_many :banks
  validates_presence_of :name
end
