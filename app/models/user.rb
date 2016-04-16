class User < ActiveRecord::Base
  attr_accessor :remember_token
  has_many :blogs, dependent: :destroy
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 100},
            format: {with: /\A[\w]+(\.|)[\w]+@[\w]+\.([a-z]+\.[a-z]+|[a-z]+)\Z/},
            uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, confirmation: true
  validates :password_confirmation, presence: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
