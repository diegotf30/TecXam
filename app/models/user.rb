class User < ApplicationRecord
  devise :database_authenticatable, :validatable, :registerable, :recoverable,
         :rememberable, :trackable, :confirmable, :lockable
end
