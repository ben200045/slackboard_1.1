class Channel < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :group_channels
  has_many :groups, through: :group_channels
end
