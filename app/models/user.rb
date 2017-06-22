class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :channels, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :direct_messages, dependent: :destroy
  has_many :conversations, dependent: :destroy

  def name
  email.split('@')[0]
  end
end
