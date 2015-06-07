class Approval < ActiveRecord::Base
  belongs_to :type_approval
  belongs_to :timeline

  validates_presence_of :file
  validates_presence_of :timeline
  validates_uniqueness_of :timeline_id
  validates_presence_of :type_approval

end
