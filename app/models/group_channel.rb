class GroupChannel < ApplicationRecord
  belongs_to :group
  belongs_to :channel
end
