class User < ActiveRecord::Base

  # Call Backs
  before_save {self.email = email.downcase}   # Downcases the inputted email address to remove uniqueness issues

  # Validation
  validates :name, presence: true
  validates :surname, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            length: {maximum: 255}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 6}

end
