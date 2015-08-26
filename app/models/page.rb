class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :body, presence: true

  def should_generate_new_friendly_id?
    title_changed?
  end
end
