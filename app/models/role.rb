class Role < ActiveRecord::Base
    has_many :teachers
    validates_presence_of :name

    def self.teacher
      find_by(name: "Professor")
    end
end
