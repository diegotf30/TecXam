class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  has_many :courses
  has_many :exams, through: :courses
  has_many :questions

  validates :name, length: { maximum: 50 }, allow_blank: true
  validates :gender, inclusion: ['male', 'female'], allow_blank: true, allow_nil: true

  def verify
    update(confirmed_at: Time.current)
  end

  def verified?
    !!confirmed_at
  end

  def tags
    questions.pluck(:tags).flatten
  end
end
