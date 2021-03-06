class User < ApplicationRecord
  has_many :articles
  before_save {self.email=email.downcase}
  has_secure_password
  validates :username, presence: true,
             uniqueness: {case_sensitive: false},
             length: {minimum: 3, maximum:25 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105},
            uniqueness: { case_sensetive: false },
            format: { with: VALID_EMAIL_REGEX }
  
  def check_authorization(current_user)
    id == current_user.id and !current_user.admin?
  end

  
end
