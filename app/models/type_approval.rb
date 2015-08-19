class TypeApproval < ActiveRecord::Base
  has_many :approval
  validates_presence_of :name
end
