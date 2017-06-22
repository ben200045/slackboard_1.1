class Group < ApplicationRecord
  belongs_to :user, optional: true 
  has_many :user_groups
  has_many :users, through: :user_groups
  has_many :group_channels
  has_many :channels, through: :group_channels
end
