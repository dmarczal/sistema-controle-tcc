class Role < ActiveRecord::Base
    has_many :teachers
    validates_presence_of :name
end
