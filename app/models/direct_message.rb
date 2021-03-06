class DirectMessage < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates :body, presence: true, length: {minimum: 2, maximum: 1000}
  
  after_create_commit { MessageBroadcastJob.perform_later(self) }
 

  def timestamp
  created_at.strftime('%H:%M')
  end

end