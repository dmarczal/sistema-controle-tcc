class Approval < ActiveRecord::Base
  belongs_to :type_approval
  belongs_to :bank
  has_attached_file :file
  validates_attachment :file, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"] }

  validates_presence_of :dropbox_file
  validates_presence_of :bank
  validates_presence_of :type_approval

end
