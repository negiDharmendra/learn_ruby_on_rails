class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_password_token
  before_create :generate_activation_digest
  has_many :blogs, dependent: :destroy
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 100},
            format: {with: /\A[\w]+(\.\w+|)+@[\w]+\.([a-z]+\.[a-z]+|[a-z]+)\Z/},
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

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def generate_reset_password_token
    self.reset_password_token = User.new_token
    update_attribute(:reset_password_digest, User.digest(self.reset_password_token))
  end
  private
  def generate_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(self.activation_token)
  end
end
