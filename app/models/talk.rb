class Talk < ApplicationRecord
  belongs_to :user
  belongs_to :property
  has_many   :messages
  belongs_to :reservation

  validates_presence_of :user, :property
  validates_presence_of :talk, :body, :user
end
