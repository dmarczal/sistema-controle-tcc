class Approval < ActiveRecord::Base
  belongs_to :type_approval
  belongs_to :bank

  validates_presence_of :file
  validates_presence_of :bank
  validates_presence_of :type_approval

end
