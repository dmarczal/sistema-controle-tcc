class Approval < ActiveRecord::Base
  belongs_to :type_approval
  belongs_to :bank

  has_attached_file(:file, {}.merge(PaperclipStorage.options))

  validates_with AttachmentSizeValidator, :attributes => :file, :less_than => 10.megabytes
  validates_with AttachmentPresenceValidator, :attributes => :file
  validates_with AttachmentContentTypeValidator, :attributes => :file, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]

  validates_presence_of :bank
  validates_presence_of :type_approval

end
