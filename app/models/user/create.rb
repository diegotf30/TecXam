class User::Create < ActiveType::Record[User]
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, length: { in: 8..128 }
  # validate :confirmation_equal?

  private

  def confirmation_equal?
    password == password_confirmation
  end
end
