class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  mount_base64_uploader :photo, PhotoUploader
  has_many :wishlists
  enum kind: [ :user, :admin ]
  enum gender: [ :homem, :mulher ]
  has_many :comments
  has_many :properties
  belongs_to :address
  has_many :reservations
  has_many :talks
  has_many :messages
end
