class Course < ApplicationRecord
    
    belongs_to :user, optional: true
    has_many :assessments
end
