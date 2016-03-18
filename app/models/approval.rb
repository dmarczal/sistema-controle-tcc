class Approval < ActiveRecord::Base
  belongs_to :type_approval
  belongs_to :bank

  VALID_CONTENT_TYPES= ["application/zip", "application/x-zip", "application/x-zip-compressed", "application/pdf"] 

  has_attached_file(:file, {}.merge(PaperclipStorage.options))
  has_attached_file(:complementary_file, {}.merge(PaperclipStorage.options))

  validates_with AttachmentSizeValidator, :attributes => :file, :less_than => 15.megabytes
  validates_with AttachmentSizeValidator, :attributes => :complementary_file, :less_than => 30.megabytes
  validates_with AttachmentPresenceValidator, :attributes => :file

  validates_with AttachmentContentTypeValidator, :attributes => :file, content_type: VALID_CONTENT_TYPES 
  validates_with AttachmentContentTypeValidator, :attributes => :complementary_file, content_type: VALID_CONTENT_TYPES 

  validates_presence_of :bank
  validates_presence_of :type_approval

  def student
    @student ||= bank.timeline.student
  end


  def self.tccs
    #includes(bank: [ timeline: [:student, :teachers] ]).where('banks._type' => 'tcc2').group_by do |ap|
    includes(bank: [ timeline: [:student, :teachers] ]).where('banks._type' => 'tcc2').group_by do |ap|
      ap.bank.date.strftime('%Y')
    end
  end

  def self.proposals
    one_year_ago('proposta').group_by do |ap|
      ap.bank.date.strftime('%Y')
    end
  end

  def self.projects
    one_year_ago('tcc1').group_by do |ap|
      ap.bank.date.strftime('%Y')
    end
  end

  private
  def self.one_year_ago(type)
      eager_load(bank: [ timeline: [:student, :teachers] ]).where('banks._type' => type).joins(:bank).where('banks.date >= ?', 1.year.ago)
  end

end
